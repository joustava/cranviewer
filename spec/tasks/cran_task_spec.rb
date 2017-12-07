require "rails_helper"

RSpec.describe "rake cran" do
  before {
    Cranviewer::Application.load_tasks
  }

  describe ":import" do
    before {
      Rake::Task['cran:import'].invoke
    }

    it "imports packages" do
      expect(Package.count).to eq(50)
    end
  end

  after do
    Rake.application.clear
  end
end
