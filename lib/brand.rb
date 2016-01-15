require_relative 'errors'
require_relative 'transaction'

# Brand class
class Brand
  attr_reader :title
  attr_accessor :stock, :products

  @@brands = []

  def initialize(options = {})
    @title = options[:title]
    @stock = 0
    @products = []
    add_to_brands
  end

  def average_price
    total_price = 0
    @products.each do |product|
      total_price += product.price
    end
    total_price / @products.length
  end

  def purchases
    purchases = 0
    Transaction.all.each do |transaction|
      purchases += 1 if transaction.product.brand == self
    end
    purchases
  end

  def sales
    sales = 0
    Transaction.all.each do |transaction|
      if transaction.product.brand == self
        sales += transaction.product.price
      end
    end
    sales
  end

  def add_product(product)
    @products << product
    @stock += product.stock
  end

  private

  def add_to_brands
    @@brands.each do |brand|
      if brand.title == @title
        raise DuplicateBrandError, "'#{@title}' already exists."
      end
    end

    @@brands << self
  end
end
