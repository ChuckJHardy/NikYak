class NiksController < AuthorizedController
  before_action :set_nik, only: [:show, :edit, :update, :destroy, :upvote, :tree]
  skip_before_action :authenticate, only: [:show, :index, :guest]

  def guest
    guest_user
    path = new_nik_path
    path = nik_path(id: params[:nik_id]) if params[:nik_id]

    redirect_to path
  end

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

  def upvote
    @nik.upvote!
    render partial: "upvote", locals: { nik: @nik }
  end

  def tree
    @tree = TreeStructure.structure2(@nik)
  end

  private

  def set_nik
    @nik = Nik.find(params[:id])
  end

  def nik_params
    params.require(:nik).permit(:title, :body, :limit, :parent_id)
  end

  def guest_user(with_retry = true)
    sign_in User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  def create_guest_user
    u = User.create(name: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@nikyak.com")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end
end
