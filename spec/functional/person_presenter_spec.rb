require 'spec_helper'

RSpec.describe PersonPresenter do
  describe '#to_s' do
    let(:person) do
      Person.new(
        {
          birthdate: '1947-05-04',
          city: 'New York City',
          first_name: 'Elliot'
        }
      )
    end

    subject do
      described_class.new(person).to_s
    end

    it 'returns the all the information in a single line' do
      expect(subject)
        .to eq "#{person.first_name}, #{person.city}, #{person.birthdate.strftime('%-m/%-d/%Y')}"
    end
  end
end
