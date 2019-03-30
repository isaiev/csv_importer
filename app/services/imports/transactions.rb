module Imports
  class Transactions

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def run
      raw_data = CSV.read(file_path).tap(&:shift)
      attributes = []

      raw_data.each_with_index do |transaction_data, i|
        location = transaction_data[0]
        employee_identifier = transaction_data[1]
        coffee_identifier = transaction_data[2]
        price = transaction_data[3]
        sold_at = transaction_data[4]

        coffeeshop = coffeeshop(location)
        coffee = coffeeshop_coffee(coffee_identifier).try(:coffee)
        employee = employee(coffeeshop, employee_identifier)

        new_transaction = Transaction.new(
          coffeeshop: coffeeshop,
          employee: employee,
          coffee: coffee,
          price: price,
          sold_at: sold_at
        )

        if new_transaction.valid?
          attributes << "(#{coffeeshop.id},#{employee.id}, #{coffee.id}, #{price}, '#{new_transaction.sold_at.to_s(:db)}')"
        end
      end

      ActiveRecord::Base.connection.execute(
        <<-SQL
         INSERT INTO transactions(coffeeshop_id,employee_id,coffee_id,price,sold_at) VALUES #{attributes.join(",")}
        SQL
      )
    end

    private

    def coffeeshop(identifier)
      @coffeeshops ||= {}

      if @coffeeshops[identifier]
        @coffeeshops[identifier]
      else
        search_result = Coffeeshop.find_by(identifier: identifier)
        @coffeeshops[identifier] = search_result if search_result
      end
    end

    def coffeeshop_coffee(identifier)
      @coffeeshop_coffees ||= {}
      @error_identifiers ||= Set.new([])

      if @error_identifiers.include?(identifier)
        return nil
      elsif @coffeeshop_coffees[identifier]
        @coffeeshop_coffees[identifier]
      else
        search_result = CoffeeshopCoffee.find_by(identifier: identifier)
        if search_result
          @coffeeshop_coffees[identifier] = search_result
        else
          @error_identifiers.add(identifier)

          return nil
        end
      end
    end

    def employee(coffeeshop, identifier)
      @employee ||= {}

      if @employee[identifier]
        @employee[identifier]
      else
        search_result = Employee.find_or_create_by(coffeeshop: coffeeshop, identifier: identifier)
        @employee[identifier] = search_result if search_result
      end
    end

  end
end
