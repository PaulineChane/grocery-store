# Pauline Chane (@PaulineChane on GitHub)
# Ada Developers Academy C14
# Grocery Store - customer.rb
# 9/28/2020

# imports
require 'csv'

# Class object spec file for Customer class.
class Customer
  # constants
  ADDRESS_TEMPLATE = %i[street city state zip].freeze

  # generic getters/setters
  attr_accessor :email, :address
  attr_reader :id

  # constructors
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # class methods

  # based on an external .csv file containing customer data,
  # returns collection (in this case, array) of customer instances
  def self.all
    customers_raw = CSV.read('data/customers.csv')

    all_customers = customers_raw.map do |customer|
      Customer.new(customer[0].to_i, customer[1], { street: customer[2], city: customer[3], state: customer[4], zip: customer[5] })
    end

    return all_customers
  end

  # returns an instance of Customer matched by id value entered as parameter in self.all
  # returns nil if id not found
  def self.find(id)
    return self.all.find{|customer| customer.id == id}
  end

  # takes filename (string of relative filepath of new file) and new_customer (Customer instance) as parameters
  # writes new_customer info into file with filename with same format as customers.csv
  def self.save(filename, new_customer)
    CSV.open(filename, 'a') do |csv|
      csv << [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zip]]
    end
  end
end
