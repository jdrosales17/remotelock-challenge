require 'spec_helper'

RSpec.describe FileReaderService do
  describe 'reads dollar format' do
    let(:person1) do
      Person.new(
        {
          birthdate: '30-4-1974',
          city: 'Los Angeles',
          first_name: 'Rhiannon',
          last_name: 'Nolan'
        }
      )
    end
    let(:person2) do
      Person.new(
        {
          birthdate: '5-1-1962',
          city: 'New York City',
          first_name: 'Rigoberto',
          last_name: 'Bruen'
        }
      )
    end

    subject do
      described_class.new(
        file: File.read('spec/fixtures/people_by_dollar.txt'),
        file_format: '$'
      ).process
    end

    it 'returns a Person object for each line in the file' do
      expect(subject.first).to have_attributes(
        birthdate: person1.birthdate,
        city: person1.city,
        first_name: person1.first_name,
        last_name: person1.last_name
      )

      expect(subject.last).to have_attributes(
        birthdate: person2.birthdate,
        city: person2.city,
        first_name: person2.first_name,
        last_name: person2.last_name
      )
    end
  end

  describe 'reads percent format' do
    let(:person1) do
      Person.new(
        {
          birthdate: '1986-05-29',
          city: 'Atlanta',
          first_name: 'Mckayla'
        }
      )
    end
    let(:person2) do
      Person.new(
        {
          birthdate: '1947-05-04',
          city: 'New York City',
          first_name: 'Elliot'
        }
      )
    end

    subject do
      described_class.new(
        file: File.read('spec/fixtures/people_by_percent.txt'),
        file_format: '%'
      ).process
    end

    it 'returns a Person object for each line in the file' do
      expect(subject.first).to have_attributes(
        birthdate: person1.birthdate,
        city: person1.city,
        first_name: person1.first_name
      )

      expect(subject.last).to have_attributes(
        birthdate: person2.birthdate,
        city: person2.city,
        first_name: person2.first_name
      )
    end
  end

  describe 'does not support any other format' do
    subject do
      described_class.new(
        file: File.read('spec/fixtures/people_by_dollar.txt'),
        file_format: '-'
      ).process
    end

    it 'raises an error' do
      expect { subject }.to raise_error('Unsupported column separator')
    end
  end
end
