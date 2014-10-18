class NiksController < AuthorizedController
  before_action :set_nik, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate, only: [:show, :index]

  def index
    @niks = Nik.roots
    respond_with(@niks)
  end

  def show
    if user_signed_in?
      @new_nik = Nik.new(user_id: current_user.id, parent: @nik.potential_parent)
    end
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
      params.require(:nik).permit(:title, :body, :limit, :parent_id)
    end
end
