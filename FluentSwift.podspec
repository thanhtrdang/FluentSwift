Pod::Spec.new do |spec|
  spec.name         = 'FluentSwift'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/thanhtrdang/FluentSwift'
  spec.authors      = { 'Thanh Dang' => 'thanhtrdang@gmail.com' }
  spec.summary      = 'Fluent layout Swift API'
  spec.source       = { :git => 'https://github.com/thanhtrdang/FluentSwift.git', :tag => spec.version.to_s }

  spec.ios.deployment_target = '8.0'

  spec.source_files = 'Source/*.swift'
end
