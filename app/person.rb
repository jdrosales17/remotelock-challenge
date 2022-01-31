require 'date'

class Person
  CITIES = {
    'LA': 'Los Angeles',
    'NYC': 'New York City'
  }.freeze

  attr_reader :birthdate, :city, :first_name, :last_name

  def initialize(args)
    @birthdate = Date.parse(args[:birthdate])
    @city = args[:city]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
  end
end
