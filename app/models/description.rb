require 'rubygems/package'
require 'zlib'
require 'open-uri'
require 'dcf'

class Description < ApplicationRecord
  include CranParseable
  belongs_to :package

  OpenURI::Buffer.send :remove_const, "StringMax"
  OpenURI::Buffer.send :const_set, "StringMax", 0

  def self.import(package)
    attributes = self.extract(package.name, package.version)
    attributes.each { |k, v|
      attributes[k] = v.force_encoding("ISO-8859-1").encode("UTF-8") unless v.blank?
    }
    package.create_description(attributes)
  rescue StandardError => e
    puts package.name
    pp e
  end

  def self.extract(package, version, packages=ARCHIVES_URI)
    archive = open("#{packages}/#{package}_#{version}.tar.gz")

    tar = Zlib::GzipReader.open(archive)

    extract = Gem::Package::TarReader.new(tar)

    desc_file = extract.detect { |file|
      file.full_name === "#{package}/DESCRIPTION"
    }

    description = self.parse(desc_file.read)
    description[:publication] = description.delete :"date/publication"
    description[:authors] = description.delete :"authors@r"
    description[:maintainers] = description.delete :"maintainers@r"
    description.slice(:author, :authors, :maintainer, :maintainers, :publication, :description, :title, :version)
  end
end
