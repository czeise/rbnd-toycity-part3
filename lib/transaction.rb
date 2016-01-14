# Transaction class
class Transaction
  attr_reader :customer, :product, :id
  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product
    @id = @@id

    product.stock -= 1

    add_to_transactions

    @@id += 1
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end
