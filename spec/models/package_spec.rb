require "rails_helper"

RSpec.describe Package, type: :model do
  context "validation"  do
    it "succeeds" do
      package = Package.create(name: "asdf", version: "1.2.3")
      expect(package).to be_valid
    end

    it "fails on missing name" do
      package = Package.create(name: "")
      expect(package).to_not be_valid
    end

    it "fails on missing version" do
      package = Package.create(name: "package", version: "")
      expect(package).to_not be_valid
    end
  end

  describe "#versions" do
    before {
      @package = Package.create(name: "asdf", version: "1")
      Package.create(name: "asdf", version: "2")
      Package.create(name: "bla", version: "1")
    }
    it "fetches all imported versions of a package" do
      expect(@package.versions.map(&:version)).to eq(["1","2"])
    end
  end

  describe ".import" do
    let(:import) { -> { Package.import(file_fixture("PACKAGES")) } }

    it "imports all packages from a cran PACKAGES definition into the db" do
      expect(import).to change { Package.count }.from(0).to(50)
    end
  end

end
