require_relative 'person'

class FileReaderService
  SUPPORTED_FILE_FORMATS = ['$', '%'].freeze

  attr_reader :file, :file_format

  def initialize(file:, file_format:)
    @file = file
    @file_format = file_format
  end

  def process
    raise 'Unsupported column separator' unless SUPPORTED_FILE_FORMATS.include?(file_format)

    people = []

    file.each_line.with_index do |line, index|
      next if index.zero?

      line_info = line.strip.split(" #{file_format} ")

      people.push(
        Person.new(person_params(line_info))
      )
    end

    people
  end

  private

  def person_params(line_info)
    case file_format
    when '$'
      {
        birthdate: line_info[1],
        city: sanitize_city(line_info[0]),
        first_name: line_info[3],
        last_name: line_info[2]
      }
    when '%'
      {
        birthdate: line_info[2],
        city: sanitize_city(line_info[1]),
        first_name: line_info[0]
      }
    end
  end

  def sanitize_city(city)
    return city unless Person::CITIES.key?(city.to_sym)

    Person::CITIES[city.to_sym]
  end
end
