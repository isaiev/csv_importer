RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation  # clean DB of any leftover data
    DatabaseCleaner.strategy = :transaction # rollback transactions between each test
    Rails.application.load_seed # (optional) seed DB
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
