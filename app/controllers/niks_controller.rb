class NiksController < ApplicationController
  before_action :set_nik, only: [:show, :edit, :update, :destroy]

  def index
    @niks = Nik.all
    respond_with(@niks)
  end

  def show
    respond_with(@nik)
  end

  def new
    @nik = Nik.new
    respond_with(@nik)
  end

  def edit
  end

  def create
    @nik = Nik.new(nik_params)
    @nik.save
    respond_with(@nik)
  end

  def update
    @nik.update(nik_params)
    respond_with(@nik)
  end

  def destroy
    @nik.destroy
    respond_with(@nik)
  end

  private
    def set_nik
      @nik = Nik.find(params[:id])
    end

    def nik_params
      params.require(:nik).permit(:title, :body, :limit, :user_id)
    end
end
