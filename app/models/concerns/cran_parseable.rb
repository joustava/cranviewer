require "dcf"
require "yaml"

module CranParseable
  extend ActiveSupport::Concern

  MIRROR = Rails.configuration.cran['mirror']
  ARCHIVES = Rails.configuration.cran['archives']
  PACKAGES = Rails.configuration.cran['packages']

  PACKAGES_URI = "#{MIRROR}/#{ARCHIVES}/#{PACKAGES}"
  ARCHIVES_URI = "#{MIRROR}/#{ARCHIVES}"

  module ClassMethods
    def parse(input)
      records = Dcf.parse(input)
      self.normalize(records.first)
    end

    def normalize(record)
      ActiveSupport::HashWithIndifferentAccess.new(record.transform_keys(&:downcase))
    end
  end
end
