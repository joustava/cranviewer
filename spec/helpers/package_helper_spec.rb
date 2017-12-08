require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PackageHelper. For example:
#
# describe PackageHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PackageHelper, type: :helper do

  it "builds link to archive" do
    package = Package.create(name: "abc", version: "1.2.3")
    expect(helper.archive_uri(package)).to include("src/contrib/abc_1.2.3.tar.gz")
  end


end
