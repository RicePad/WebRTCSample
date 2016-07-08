class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update ]

  def new
    @user = User.new
  end

  #PAPERCLIP
  def create
    @user = User.new( user_params )
    if @user.save
      redirect_to @user, notice: "Image or video was successfully uploaded"
      else
      render action: 'new'
    end
  end


  def edit
    #using require_same_user from Private and is linked from the top two 'before_action'
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    #Showing user reviews
    @reviews = Review.where(user_id: @user.id).order("created_at DESC")
      #shows average user review (Not working?)
    if @review.blank?
      @avg_review = 0
      else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 3)
  end

private
  def user_params
  params.require(:user).permit(:name, :firstname, :lastname, :about, :avatar, :video, :image)
  end

  def set_user
  @user = User.find(params[:id])
  end

#requires same user to edit their user profile.
  def require_same_user
    if current_user != @user
      flash[:danger] = "you can only edit your own account"
      redirect_to root_path
    end
  end

end
