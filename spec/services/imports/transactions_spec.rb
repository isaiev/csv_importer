module Imports
  describe Transactions do
    describe '#run' do
      subject(:importer) { described_class.new(file_path).run }

      let(:file_path) { Rails.root.join('spec/fixtures/transactions.csv') }
      let(:shop_a) { Coffeeshop.find_by(name: 'Coffeeshop A') }
      let(:shop_b) { Coffeeshop.find_by(name: 'Coffeeshop B') }
      let(:coffee_list) { CoffeeshopCoffee.pluck(:identifier, :coffee_id).to_h }

      it 'creates 7 transactions' do
        expect { subject }.to change { Transaction.count }.from(0).to(8)
      end

      it 'creates employees with correct data' do
        subject

        current_data = Transaction.pluck(:coffeeshop_id, :employee_id, :coffee_id, :price, :sold_at)
        expected_data = [
          [shop_a.id, 1, coffee_list['C01'], 2.00.to_d, Time.find_zone('UTC').parse('2018-12-05 12:00:23')],
          [shop_a.id, 2, coffee_list['C02'], 2.10.to_d, Time.find_zone('UTC').parse('2018-12-05 12:00:41')],
          [shop_a.id, 1, coffee_list['C02'], 2.40.to_d, Time.find_zone('UTC').parse('2018-12-11 14:00:04')],
          [shop_a.id, 2, coffee_list['C01'], 2.50.to_d, Time.find_zone('UTC').parse('2018-12-11 14:00:56')],
          [shop_b.id, 3, coffee_list['ESP'], 2.30.to_d, Time.find_zone('UTC').parse('2018-12-05 12:34:26')],
          [shop_b.id, 3, coffee_list['CAP'], 2.60.to_d, Time.find_zone('UTC').parse('2018-12-11 14:41:44')],
          [shop_b.id, 3, coffee_list['ESP'], 2.70.to_d, Time.find_zone('UTC').parse('2018-12-11 14:42:58')],
          [shop_b.id, 3, coffee_list['CAP'], 2.20.to_d, Time.find_zone('UTC').parse('2018-12-05 12:33:55')]
        ]

        expect(current_data).to eq(expected_data)
      end


      context 'with big transactions file' do
        subject(:importer) { described_class.new(file_path).run }

        let(:file_path) { Rails.root.join('spec/fixtures/transactions_big.csv') }

        it 'creates 67 000 transactions' do
          expect { subject }.to change { Transaction.count }.from(0).to(67200)
        end

        it 'executes less then a 60000 milliseconds(1 minute)' do
          expect { subject }.to perform_under(60000).ms
        end

        it 'creates valid transactions' do
          subject

          expect(Transaction.all.all?(&:valid?)).to eq(true)
        end
      end
    end
  end
end
