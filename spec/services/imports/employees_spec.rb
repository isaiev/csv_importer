module Imports
  describe Employees do
    describe '#run' do
      subject(:importer) { described_class.new(file_path).run }

      let(:file_path) { Rails.root.join('spec/fixtures/employees.csv') }
      let!(:coffeshop_a) { create(:coffeeshop, identifier: 'Location1', name: 'Coffeeshop A') }
      let!(:coffeshop_b) { create(:coffeeshop, identifier: 'Location2', name: 'Coffeeshop B') }

      it 'creates 6 employees' do
        expect { subject }.to change{ Employee.count }.from(0).to(6)
      end

      it 'creates employees with correct data' do
        subject

        current_data = Employee.pluck(:coffeeshop_id, :identifier, :name)
        expected_data = [
          [coffeshop_a.id, 'EMP01', 'John Smith'],
          [coffeshop_a.id, 'EMP02', 'João Ninguém'],
          [coffeshop_a.id, 'EMP03', 'John Smith'],
          [coffeshop_b.id, 'STAFF01', 'John Smith'],
          [coffeshop_b.id, 'STAFF02', 'Janina Kowalska'],
          [coffeshop_b.id, 'STAFF03', 'Petro Petrenko'],
        ]

        expect(current_data).to eq(expected_data)
      end

    end
  end
end

