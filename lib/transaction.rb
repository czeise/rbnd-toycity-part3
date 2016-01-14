# Transaction class
class Transaction
  attr_reader :customer, :product, :id
  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product

    if product.stock == 0
      raise OutOfStockError, "'#{product.title}' is out of stock."
    end

    @id = @@id

    product.stock -= 1

    add_to_transactions

    @@id += 1
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions[id - 1]
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end
