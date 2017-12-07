require "rails_helper"

RSpec.describe Description, type: :model do

  describe ".extract" do
    it "extracts a package description from its tar archive" do
      expect(
        Description.extract("A3", "1.0.0", file_fixture("src/contrib"))
      ).to include(
        {
          "author" => "Scott Fortmann-Roe",
          "publication" => "2015-08-16 23:05:52",
          "description" => "Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
          "maintainer" => "Scott Fortmann-Roe <scottfr@berkeley.edu>",
          "title" => "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
          "version" => "1.0.0",
        }
      )
    end

    it "handles encoding" do
      expect(
        Description.extract("BoolNet", "2.1.3", file_fixture("src/contrib"))
      ).to include(
        {
          "author" => "Christoph Müssel [aut], Martin Hopfensitz [aut], Dao Zhou [aut], Hans A. Kestler [aut, cre], Armin Biere [ctb] (contributed PicoSAT code), Troy D. Hanson [ctb] (contributed uthash macros)",
          "publication" => "2016-11-21 12:23:47",
          "description" => "Provides methods to reconstruct and generate synchronous, asynchronous, probabilistic and temporal Boolean networks, and to analyze and visualize attractors in Boolean networks.",
          "maintainer" => "Hans A. Kestler <hans.kestler@uni-ulm.de>",
          "title" => "Construction, Simulation and Analysis of Boolean Networks",
          "version" => "2.1.3",
        }
      )
    end

    it "raises error on invalid package" do
      expect {
        Description.extract("A3", "1.0.1")
      }
      .to raise_error(StandardError)
    end
  end
end
