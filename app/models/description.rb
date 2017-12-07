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
    package.create_description(attributes)
  rescue StandardError => e
    pp e
    puts package.name
    logger.debug(e)
  end

  def self.extract(package, version, packages=ARCHIVES_URI)
    archive = open("#{packages}/#{package}_#{version}.tar.gz")

    tar = Zlib::GzipReader.open(archive)

    extract = Gem::Package::TarReader.new(tar)

    content = extract.seek("#{package}/DESCRIPTION") { |entry|
      entry.read
    }

    #content.force_encoding("utf-8")
    description = self.parse(content)
    description[:publication] = description.delete :"date/publication"
    description.slice(:author, :authors, :maintainer, :maintainers, :"publication", :description, :title, :version)
  end
end
