class PackagesController < ApplicationController
  helper PackageHelper

  def index
    @packages = Package.latest
  end

  def show
    @package = Package.find(params[:id])
  end

  def description
    @package = Package.find(params[:id])
  end

end
