class MentoringsController < ApplicationController
  before_action :set_mentoring, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]

  def seller
    @mentorings = Mentoring.where(user: current_user).order("created_at DESC")
  end

  def index
    @mentorings = Mentoring.all.order("created_at DESC")
  end

  def show
  end

  def new
    @mentoring = Mentoring.new
  end

  def edit
  end

  def create
    @mentoring = Mentoring.new(mentoring_params)
    @mentoring.user_id = current_user.id

    if current_user.recipient.blank?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token= params[:stripeToken]

      recipient = Stripe::Recipient.create(
        :name => current_user.name,
        :type => "individual",
        :bank_account => token
        )

      current_user.recipient = recipient.id
      current_user.save
    end

    respond_to do |format|
      if @mentoring.save
        format.html { redirect_to @mentoring, notice: 'Mentoring was successfully created.' }
        format.json { render :show, status: :created, location: @mentoring }
      else
        format.html { render :new }
        format.json { render json: @mentoring.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mentoring.update(mentoring_params)
        format.html { redirect_to @mentoring, notice: 'Mentoring was successfully updated.' }
        format.json { render :show, status: :ok, location: @mentoring }
      else
        format.html { render :edit }
        format.json { render json: @mentoring.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mentoring.destroy
    respond_to do |format|
      format.html { redirect_to mentorings_url, notice: 'Mentoring was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mentoring
      @mentoring = Mentoring.find(params[:id])
    end

    def mentoring_params
      params.require(:mentoring).permit(:name, :description, :price)
    end

    def check_user
      if current_user != @mentoring.user
        redirect_to root_url, alert: "Sorry, that page belongs to a different mentor"
      end
    end
end
