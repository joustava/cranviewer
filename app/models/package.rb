require 'open-uri'

class Package < ApplicationRecord
  include CranParseable

  has_one :description

  validates_length_of :name, :minimum => 2, :allow_blank => false
  validates_length_of :version, :minimum => 1, :allow_blank => false

  def versions
    Package.select("id", "name", "version").where(:name => self.name)
  end

  def latest
    self.versions.last
  end

  def self.import(options={})
    uri = options.fetch(:uri, PACKAGES_URI)
    size = options.fetch(:size, 50)

    raw_records = self.fetch(uri).lazy.take(size)

    records = raw_records.map do |raw_record|
      self.parse(raw_record)
    end

    Upsert.batch(Package.connection, Package.table_name) do |package|
      records.each do |record|
        package.row({name: record[:package], version: record[:version]}, {
          created_at: Time.now,
          updated_at: Time.now
        })
      end
    end

    Package.find_each do |package|
      if(package.description.blank?)
        #DescriptionImportJob.perform_now package
        PackageArchiveImport.enqueue(package.id)
      end
    end
  end


  private


  def self.fetch(uri)
    file = Tempfile.new('packages_tmp', encoding: 'UTF-8')
    open(uri) do |listing|
      file.write(listing.read)
    end

    file.rewind

    Enumerator.new do |yields|
      record = ""
      file.each_line.lazy.each do |line|
        if line.start_with?("Package", "Version")
          record << line
        end
        if line === "\n" or file.eof?
          yields << record
          record = ""
        end
      end
    end
  end

end
