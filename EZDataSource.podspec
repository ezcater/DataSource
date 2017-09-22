Pod::Spec.new do |s|
  s.name             = 'EZDataSource'
  s.version          = '0.3.0'
  s.summary          = 'Concise, flexible, and UI independent protocol for data sources'
  s.description      = <<-DESC
  Concise, flexible, and UI independent protocol for data sources.
                       DESC

  s.homepage         = 'https://github.com/ezcater/DataSource'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Brad Smith' => 'bsmith@ezcater.com' }
  s.source           = { :git => 'https://github.com/ezcater/DataSource.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bsmithers11'

  s.ios.deployment_target = '8.0'
  s.source_files = 'DataSource/Classes/**/*'

end
