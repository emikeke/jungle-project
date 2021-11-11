class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]

  def show
    @product_count = Product.all.product.count
    @category_count = Category.all.count
  end
end
