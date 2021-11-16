require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new
  end

  describe 'Validations' do
    it 'Product can be added with name, price, quantity, and category' do
      @product = @category.products.new(name: 'Electric CHair', price: 987.65, quantity: 2)
      expect(@category).to be_valid
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @product = @category.products.new(name: nil, price: 125, quantity: 18)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq 'Name can\'t be blank'
    end

    it 'is not valid without a price' do
      @product = @category.products.new(name: 'Electric CHair', price: nil, quantity: 2)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq 'Price cents is not a number'
    end

    it 'is not valid without a quantity' do
      @product = @category.products.new(name: 'Electric CHair', price: 987.65, quantity: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq 'Quantity can\'t be blank'
    end

    it 'is not valid without a category' do
      @product = Product.new(name: 'Women\'s Zebra pants', price: 125, quantity: 18, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq 'Category can\'t be blank'
    end
  end
end
