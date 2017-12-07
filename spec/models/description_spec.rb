require "rails_helper"

RSpec.describe Description, type: :model do

  describe ".extract" do
    it "extracts a package description from its tar archive" do
      expect(
        Description.extract("A3", "1.0.0", file_fixture("archives"))
      ).to include(
        {
          "author" => "Scott Fortmann-Roe",
          #"date" => "2015-08-15",
          #"date/publication" => "2015-08-16 23:05:52",
          "publication" => "2015-08-16 23:05:52",
          #"depends" => "R (>= 2.15.0), xtable, pbapply",
          "description" => "Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
          #"license" => "GPL (>= 2)",
          "maintainer" => "Scott Fortmann-Roe <scottfr@berkeley.edu>",
          #"needscompilation" => "no",
          "package" => "A3",
          #"packaged" => "2015-08-16 14:17:33 UTC; scott",
          #"repository" => "CRAN",
          #"suggests" => "randomForest, e1071",
          "title" => "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
          #"type" => "Package",
          "version" => "1.0.0",
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
