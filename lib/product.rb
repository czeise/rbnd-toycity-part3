require_relative 'errors'

# Product class
class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.each do |product|
      return product if product.title == title
    end
  end

  def in_stock?
    @stock > 0 ? true : false
  end

  def self.in_stock
    products_in_stock = []
    @@products.each do |product|
      if product.stock > 0
        products_in_stock << product
      end
    end
    products_in_stock
  end

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError if product.title == @title
    end

    @@products << self
  end
end
