class NiksController < ApplicationController
  before_action :authenticate_user!, expect: [:index, :show]
  before_action :set_nik, only: [:show, :edit, :update, :destroy]

  def index
    @niks = Nik.roots
    respond_with(@niks)
  end

  def show
    @yak = Yak.new
    respond_with(@nik)
  end

  def new
    @nik = Nik.new
    respond_with(@nik)
  end

  def edit
  end

  def create
    @nik = Nik.new nik_params.merge(user_id: current_user.id)
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
      params.require(:nik).permit(:title, :body, :limit)
    end
end
