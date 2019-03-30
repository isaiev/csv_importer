require 'csv'

namespace :import do
  task employees: :environment do
    file_path = Rails.root.join('support/employees.csv')
    Imports::Employees.run(file_path)
  end

  task transactions: :environment do
    file_path = Rails.root.join('support/transactions.csv')
    Imports::Transactions.run(file_path)
  end
end
