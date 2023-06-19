class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index

    @floors = Room.distinct.pluck(:floor_number).uniq.sort
    @selected_floor = params[:floor] || session[:selected_floor]
    @desks = Desk.where(floor_number: @selected_floor)
    @rooms = Room.where(floor_number: @selected_floor)

    @new_room = Room.new
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  def desks_in_room(room)
    Desk.all.select do |desk|
        desk_in_room?(desk, room)
    end
  end

  def desk_in_room?(desk, room)
      desk.pos_x >= room.top_left_x && 
      desk.pos_x < room.top_left_x + room.width &&
      desk.pos_y >= room.top_left_y && 
      desk.pos_y < room.top_left_y + room.height
  end


  def book
    room = Room.find(params[:id])
    room.toggle_booking(current_user)
  
    desks_in_room(room).each do |desk|
      desk.toggle_booking(current_user)
    end
  
    redirect_to rooms_path
  end
  
  def unbook
    room = Room.find(params[:id])
    room.toggle_booking(nil)
  
    desks_in_room(room).each do |desk|
      desk.toggle_booking(nil)
      desk.save
    end
  
    redirect_to rooms_path
  end
  

  # POST /rooms or /rooms.json
  def create
    @new_room = Room.new(room_params)
  
    if @new_room.save
      flash[:notice] = 'Desk created successfully.'
      redirect_to rooms_path(floor: @selected_floor)
    else
      render :index
    end
  end


  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to rooms_path, notice: 'Room removed successfully.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:floor_number, :top_left_x, :top_left_y, :width, :height, :booked_by)
    end
end

