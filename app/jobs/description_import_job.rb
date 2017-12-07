class DescriptionImportJob < ApplicationJob
  queue_as :description_import

  def perform(package)
    Description.import(package)
  end
end
