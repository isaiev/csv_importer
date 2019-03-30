module Imports
  class Employees

    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def run
      employees = CSV.read(file_path).tap(&:shift)

      employees.each do |employee|
        coffeeshop = Coffeeshop.find_by(identifier: employee[0])

        Employee.create!(coffeeshop: coffeeshop, identifier: employee[1], name: employee[2])
      end
    end
  end
end
