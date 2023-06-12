class DesksController < ApplicationController
  before_action :set_desk, only: %i[ show edit update destroy ]

  # GET /desks or /desks.json
  def index
    @floors = Desk.distinct.pluck(:floor_number).uniq.sort
    @selected_floor = params[:floor] || session[:selected_floor]
    @desks = Desk.where(floor_number: @selected_floor)

    session[:selected_floor] = @selected_floor
    @new_desk = Desk.new
  end
  

  # GET /desks/1 or /desks/1.json
  def show
  end

  # GET /desks/new
  def new
    @desk = Desk.new
  end

  # GET /desks/1/edit
  def edit
  end

  # POST /desks or /desks.json
  def create
    @desk = Desk.new(desk_params)

    respond_to do |format|
      if @desk.save
        format.html { redirect_to desk_url(@desk), notice: "Desk was successfully created." }
        format.json { render :show, status: :created, location: @desk }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /desks/1 or /desks/1.json
  def update
    respond_to do |format|
      if @desk.update(desk_params)
        format.html { redirect_to desk_url(@desk), notice: "Desk was successfully updated." }
        format.json { render :show, status: :ok, location: @desk }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desks/1 or /desks/1.json
  def destroy
    @desk.destroy

    respond_to do |format|
      format.html { redirect_to desks_url, notice: "Desk was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def book
    @desk = Desk.find(params[:id])
    if @desk.toggle_booking(current_user)
      redirect_to desks_path, notice: 'Desk booked successfully.'
    else
      redirect_to desks_path, alert: 'Unable to book the desk.'
    end
  end

  def unbook
    @desk = Desk.find(params[:id])
    if @desk.toggle_booking(current_user)
      redirect_to desks_path, notice: 'Desk booking canceled.'
    else
      redirect_to desks_path, alert: 'Unable to cancel the desk booking.'
    end
  end

  def create
    @new_desk = Desk.new(desk_params)
  
    if @new_desk.save
      flash[:notice] = 'Desk created successfully.'
      redirect_to desks_path(floor: @selected_floor)
    else
      render :index
    end
  end
  
  private
  
  def desk_params
    params.require(:desk).permit(:floor_number, :pos_x, :pos_y)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desk
      @desk = Desk.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def desk_params
      params.require(:desk).permit(:floor_number, :pos_x, :pos_y, :booked_by)
    end
end
