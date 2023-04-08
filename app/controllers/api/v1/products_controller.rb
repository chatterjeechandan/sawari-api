class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    begin
      product = Product.find(params[:id])
      render json: product, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Product not found" }, status: :not_found
    end
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    if product.destroy
      head :no_content
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :brand, :price)
  end
end


