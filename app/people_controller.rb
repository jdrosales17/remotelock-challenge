require_relative 'file_reader_service'
require_relative 'person_presenter'

class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    people = FileReaderService.new(file: params[:dollar_format], file_format: '$').process
    people += FileReaderService.new(file: params[:percent_format], file_format: '%').process

    people.sort_by!(&params[:order]).map { |person| PersonPresenter.new(person).to_s }
  end

  private

  attr_reader :params
end
