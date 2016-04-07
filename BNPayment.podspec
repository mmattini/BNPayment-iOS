Pod::Spec.new do |spec|
  spec.name             = "BNPayment"
  spec.version          = ENV['LIBRARY_VERSION'] ? ENV['LIBRARY_VERSION'] : "0.0.17"
  spec.summary          = "BNPayment is part of the Bambora Native SDK. This module makes it possible to register credit cards and make payments."
  build_tag             = spec.version
  spec.homepage         = "http://bambora.com"
  spec.license          = 'MIT'
  spec.author           = { "Bambora On Mobile AB" => "sdk@bambora.com" }
  spec.source           = {
                          :git => "https://github.com/bambora/BNPayment-iOS-internal",
                          :tag => build_tag.to_s
                          }
  spec.platform         = :ios, '8.0'
  spec.requires_arc     = true
  spec.source_files     = 'Pod/Classes/**/*'
  spec.resource_bundles = { 'BNPayment' => ['Pod/Assets/**/*.{png,bundle,xib,nib}'] }
  spec.dependency 'BNBase'
end