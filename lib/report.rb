require_relative 'product'
require_relative 'transaction'
require_relative 'brand'

# Report class
class Report
  # QUESTION: I wasn't sure if running the whole report from the initialize
  # method was a good idea, but it works well because it allows me to keep the
  # rest of the methods private...is there a better way to do this???
  def initialize
    setup_file # create the file
    create_report # create the report!
    close_file
  end

  private

  def setup_file
    @report_file = File.new('report.txt', 'w+')
  end

  def close_file
    @report_file.close
  end

  # Prints the top portion of the report
  def print_heading
    @report_file.puts
    @report_file.puts('  #####                                 ######')
    @report_file.puts(' #     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####')
    @report_file.puts(' #        #  #  #      #      #         #     # #      #    # #    # #    #   #')
    @report_file.puts('  #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #')
    @report_file.puts('       # ###### #      #           #    #   #   #      #####  #    # #####    #')
    @report_file.puts(' #     # #    # #      #      #    #    #    #  #      #      #    # #   #    #')
    @report_file.puts('  #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #')
    @report_file.puts('********************************************************************************')
    @report_file.puts
  end

  def print_products_header
    @report_file.puts('                     _            _')
    @report_file.puts('                    | |          | |      ')
    @report_file.puts(' _ __  _ __ ___   __| |_   _  ___| |_ ___ ')
    @report_file.puts("| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|")
    @report_file.puts('| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\')
    @report_file.puts('| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/')
    @report_file.puts('| |                                       ')
    @report_file.puts('|_|                                       ')
    @report_file.puts
  end

  def stars
    '*' * 36
  end

  # Print the retail price of the toy
  def product_price(toy)
    "Retail Price: $#{toy.price}"
  end

  # Calculate and print the total number of purchases
  def total_purchases(toy)
    num_purchases = 0

    Transaction.all.each do |transaction|
      num_purchases += 1 if transaction.product == toy
    end

    "Total Purchases: #{num_purchases}"
  end

  def calculate_total_sales(toy)
    total_sales = 0

    Transaction.all.each do |transaction|
      total_sales += transaction.product.price if transaction.product == toy
    end

    total_sales
  end

  # Calculate and print the total amount of sales
  def total_sales(toy)
    'Total sales: $' + format('%.2f', calculate_total_sales(toy))
  end

  # Print the total stock
  def product_stock(toy)
    "Toy Stock: #{toy.stock}"
  end

  # Returns an array of strings to make up the info section of a product
  def analyze_product(toy)
    [
      toy.title, stars, product_price(toy), total_purchases(toy),
      total_sales(toy), product_stock(toy), stars, "\n"
    ]
  end

  def analyze_products
    # For each product in the data set:
    Product.all.each do |toy|
      # Print out product info
      @report_file.puts analyze_product toy
    end
  end

  def make_products_section
    print_products_header
    analyze_products
  end

  def print_brands_header
    @report_file.puts(' _                         _     ')
    @report_file.puts('| |                       | |    ')
    @report_file.puts('| |__  _ __ __ _ _ __   __| |___ ')
    @report_file.puts("| '_ \\| '__/ _` | '_ \\ / _` / __|")
    @report_file.puts('| |_) | | | (_| | | | | (_| \\__ \\')
    @report_file.puts('|_.__/|_|  \\__,_|_| |_|\\__,_|___/')
    @report_file.puts
  end

  # Count and print the number of the brand's toys we stock
  def brand_stock(brand)
    "Toy Stock: #{brand.stock}"
  end

  # Calculate and print the average price of the brand's toys
  def average_brand_price(brand)
    'Average Product Price: $' + format('%.2f', brand.average_price)
  end

  # Print the total purchases for the brand
  def brand_purchases(brand)
    "Total Purchases: #{brand.purchases}"
  end

  # Calculate and print the total sales volume of all the brand's toys combined
  def total_brand_sales(brand)
    "Total sales: $#{brand.sales}"
  end

  def analyze_brand(brand)
    # Print the name of the brand
    [
      brand.title, stars, brand_stock(brand), average_brand_price(brand),
      brand_purchases(brand), total_brand_sales(brand), stars, "\n"
    ]
  end

  def analyze_brands
    # For each brand in the data set:
    Brand.all.each do |brand|
      @report_file.puts analyze_brand(brand)
    end
  end

  def make_brands_section
    print_brands_header
    analyze_brands
  end

  def print_data
    make_products_section
    make_brands_section
  end

  def create_report
    print_heading
    # Print today's date
    @report_file.puts(Time.new.strftime('%B %d, %Y'))
    print_data
  end
end
