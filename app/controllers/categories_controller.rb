class CategoriesController < ApplicationController
  before_action :authorize_request , except: :search
  before_action :set_category, only: [:show]

  def index 
    @categories = Category.all
    render json: @categories
  end 


  def search 
    @parameter = params[:search]
    
    @categories = Category.all
    @categories = @categories.where("categories.name LIKE ? ", "%#{@parameter}%")
    render json: @categories
  end


  def create 
    @category = Category.new(category_params)
    
    if @category.save
      
      render json: @category
      
    end
  end 

  def destroy
    @Category = Category.find(params[:id])

    @Category.destroy
  end



  private 
    
  
    def category_params
        params.permit(:name)
    end

    def set_category
      @category = Category.find_by_slug(params[:id])
    end

end
