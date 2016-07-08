class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  #To create a new category, go to rails console from the terminal. Type in: category= Category.create(name: "stocks")
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was successfully created"
      else
        render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_users = @category.users.paginate(page: params[:page], per_page: 5)
  end

private
  def category_params
     params.require(:category).permit(:name)
  end
end