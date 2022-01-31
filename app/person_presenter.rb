class PersonPresenter
  attr_reader :person

  def initialize(person)
    @person = person
  end

  def to_s
    "#{person.first_name}, #{person.city}, #{person.birthdate.strftime('%-m/%-d/%Y')}"
  end
end
