class YaksController < ApplicationController
  before_action :set_yak, only: [:show, :edit, :update, :destroy]

  def index
    @yaks = Yak.all
    respond_with(@yaks)
  end

  def show
    respond_with(@yak)
  end

  def new
    @yak = Yak.new
    respond_with(@yak)
  end

  def edit
  end

  def create
    @yak = Yak.new(yak_params)
    @yak.save
    respond_with(@yak)
  end

  def update
    @yak.update(yak_params)
    respond_with(@yak)
  end

  def destroy
    @yak.destroy
    respond_with(@yak)
  end

  private
    def set_yak
      @yak = Yak.find(params[:id])
    end

    def yak_params
      params.require(:yak).permit(:body, :nik_id, :user_id)
    end
end
