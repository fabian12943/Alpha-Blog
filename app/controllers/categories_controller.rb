class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :require_admin, except: [:index]

  def index
    @categories = Category.order(name: :asc).paginate(page: params[:page], per_page: Category::PAGE_LIMIT)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category '#{@category.name}' was successfully created."
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category '#{@category.name}' was deleted successfully."
  end

  private
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :tag_color, :image)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      redirect_to categories_path, alert: "You are not authorized to access this section."
    end
  end

end