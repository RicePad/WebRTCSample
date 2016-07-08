class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /meetings
  # GET /meetings.json

  def sales
    @meetings = Meeting.all.where(seller: current_user).meeting("created_at DESC")
  end

  def purchases
    @meetings = Meeting.all.where(buyer: current_user).meeting("created_at DESC")
  end

  def new
    @meeting = Meeting.new
    @mentoring = Mentoring.find(params[:mentoring_id])
  end

  def create

    customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
    )

    @meeting = Meeting.new(meeting_params)
    @mentoring = Mentoring.find(params[:mentoring_id])
    @seller = @mentoring.user

    @meeting.mentoring_id = @mentoring.id
    @meeting.buyer_id = current_user.id
    @meeting.seller_id = @seller.id

    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => (@mentoring.price * 100).floor,
        :currency => "usd",
        :card => token
        )
    rescue Stripe::CardError => e
      flash[:danger] = e.message
    end

    transfer = Stripe::Transfer.create(
      :amount => (@mentoring.price * 95).floor,
      :currency => "usd",
      :recipient => @seller.recipient
      )

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:address, :city, :state)
    end
end
