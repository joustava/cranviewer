require "rails_helper"

RSpec.describe "rake cran" do
  before {
    Cranviewer::Application.load_tasks
  }

  describe ":import" do

    it "imports packages" do
      expect {
        system("rake cran:import -- --size=1")
      }
      .to change { Package.count }.from(0).to(1)
      .and change { Description.count }.from(0).to(1)
    end
  end

  after do
    Rake.application.clear
  end
end
