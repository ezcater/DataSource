Pod::Spec.new do |s|
  s.name             = 'EZDataSource'
  s.version          = '0.7.1'
  s.summary          = 'Concise, flexible, and UI independent protocol for data sources'
  s.description      = <<-DESC
  Concise, flexible, and UI independent protocol for data sources.
                       DESC

  s.homepage         = 'https://github.com/ezcater/DataSource'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ezCater' => 'dev-mobile-team@ezcater.com' }
  s.source           = { :git => 'https://github.com/ezcater/DataSource.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.2'
  s.swift_version = '5.5'
  s.source_files = 'DataSource/Classes/**/*'

end
