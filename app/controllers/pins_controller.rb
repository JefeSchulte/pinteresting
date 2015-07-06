class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @pins = Pin.all.order('created_at DESC')
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # For some reason, this alert shows up twice. Once in the alert field and then just below it. Don't know why.
    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Edit your own pins. -Napolean Dynamite" if @pin.nil?
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
