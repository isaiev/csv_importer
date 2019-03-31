# frozen_string_literal: true

RSpec.describe 'RSpec::Benchmark::ComplexityMatcher', '#perform_exponential' do
  # exponential
  def fibonacci(n)
    n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2)
  end

  it "propagates error inside expectation" do
    expect {
      expect { raise 'boom' }.to perform_exponential
    }.to raise_error(StandardError, /boom/)
  end

  context "expect { ... }.to perfom_exponential" do
    it "passes if the block performs exponential" do
      expect { |n, i|
        fibonacci(n)
      }.to perform_exponential.in_range(1, 15).ratio(2).sample(100)
    end

    it "fails if the block doesn't perform exponential" do
      expect {
        expect { |n| n }.to perform_exponential.in_range(1, 10_000).sample(100)
      }.to raise_error("expected block to perform exponential, but performed constant")
    end
  end

  context "expect { ... }.not_to perfom_exponential" do
    it "passes if the block does not perform exponential" do
      expect { |n| n }.not_to perform_exponential.in_range(1, 10_000).sample(100)
    end

    it "fails if the block doesn't perform exponential" do
      expect {
        expect { |n|
          fibonacci(n)
        }.not_to perform_exponential.in_range(1, 15).ratio(2).sample(100)
      }.to raise_error("expected block not to perform exponential, but performed exponential")
    end
  end
end
