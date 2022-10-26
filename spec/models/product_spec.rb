require 'rails_helper'
require './app/controllers/admin/products_controller'
require './app/controllers/admin/categories_controller'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid if name, price, quantity and category are present" do
      category_params = {
        name: 'category'
      }
      @category = Category.new(category_params)
      product_params = {
        name: 'string',
        category: @category,
        quantity: 4,
        price: 40
      }
      
      @product = Product.new(product_params)
      
      expect(@product.save).to eq(true)
      #expect(@product.errors.full_messages[0]).to be_empty
    end

    it "is not valid if name is not present" do
      category_params = {
        name: 'category'
      }
      @category = Category.new(category_params)
      product_params = {
        name: nil,
        category: @category,
        quantity: 4,
        price: 40
      }
      
      @product = Product.new(product_params)

      expect(@product.save).to eq(false)
      #expect(@product.errors.full_messages[0]).to_not be_empty
    end

    it "is not valid if price is not present" do
      category_params = {
        name: 'category'
      }
      @category = Category.new(category_params)
      product_params = {
        name: 'string',
        category: @category,
        quantity: 4
      }
      
      @product = Product.new(product_params)

      expect(@product.save).to eq(false)
      #expect(@product.errors.full_messages[0]).to_not be_empty
    end

    it "is not valid if quantity is not present" do
      category_params = {
        name: 'category'
      }
      @category = Category.new(category_params)
      product_params = {
        name: 'string',
        category: @category,
        price: 40
      }
      
      @product = Product.new(product_params)
      
      expect(@product.save).to eq(false)
      #expect(@product.errors.full_messages[0]).to_not be_empty
    end

    it "is not valid if category is not present" do
      category_params = {
        name: 'category'
      }
      @category = Category.new(category_params)
      product_params = {
        name: 'string',

        quantity: 4,
        price: 40
      }
      
      @product = Product.new(product_params)
      
      expect(@product.save).to eq(false)
      #expect(@product.errors.full_messages[0]).to_not be_empty
    end
  end
end
