Pod::Spec.new do |spec|
  spec.name             = "BNPayment"
  spec.version          = ENV['LIBRARY_VERSION'] ? ENV['LIBRARY_VERSION'] : "1.1.1"
  spec.summary          = "The Native Payment SDK from Bambora makes it simple to accept credit card payments in your app."
  build_tag             = spec.version
  spec.homepage         = "http://bambora.com"
  spec.license          = 'MIT'
  spec.author           = { "Bambora On Mobile AB" => "sdk@bambora.com" }
  spec.source           = {
                          :git => "https://github.com/bambora/BNPayment-iOS.git",
                          :tag => build_tag.to_s
                          }
  spec.platform         = :ios, '8.0'
  spec.requires_arc     = true
  spec.source_files     = 'BNPayment/**/*'
  spec.resource_bundles = {
                            'BNPayment' => ['Assets/**/*.{png,bundle,xib,nib,cer}']
                          }
end