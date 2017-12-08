module PackageHelper
  def mirror
    Rails.configuration.cran['mirror']
  end

  def archives
    Rails.configuration.cran['archives']
  end

  def label(package)
    "#{package.name} (latest #{package.version})"
  end

  def archive_uri(package)
    "#{self.mirror}/#{self.archives}/#{package.name}_#{package.version}.tar.gz"
  end
end
