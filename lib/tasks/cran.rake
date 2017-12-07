require 'optparse'

namespace :cran do
  desc "Import current version of all CRAN packages"
  task import: :environment do
    
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: rake cran:import [options]"
      opts.on("-u", "--uri ARG", String) { |uri| options[:uri] = uri }
      opts.on("-s", "--size ARG", Integer) { |size| options[:size] = size }
    end

    args = parser.order!(ARGV) {}
    parser.parse!(args)

    begin
      puts "importing..."
      Package.import(options)
    rescue StandardError => e
      puts e
    end
  end

  # desc "Show package description"
  # task list: :environment do
  #   begin
  #     puts ARGV.inspect
  #     Description.extract
  #     task name.to_sym do ; end
  #   rescue StandardError => e
  #     puts e
  #   end
  # end
end
