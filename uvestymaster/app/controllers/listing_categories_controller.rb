class ListingCategoriesController < ApplicationController
  def index
    @listingcategories = ListingCategory.all
  end

  #To create a new category, go to rails console from the terminal. Type in: category= Category.create(name: "stocks")
  def new
    @listingcategory = ListingCategory.new
  end

  def create
    @listingcategory = ListingCategory.new(listingcategory_params)
    if @listingcategory.save
      flash[:success] = "Category was successfully created"
      else
        render 'new'
    end
  end

  def show
    @listingcategory = ListingCategory.find(params[:id])
    @listing_category_users = @listingcategory.listingsuser.paginate(page: params[:page], per_page: 5)
  end

private
  def listing_category_params
     params.require(:category).permit(:name)
  end
end