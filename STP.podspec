Pod::Spec.new do |s|
  s.name     = 'STP'
  s.version  = '0.1.0'
  s.author   = { 'Chris O\'Neil' => 'cconeil5@gmail.com' }
  s.homepage = 'https://github.com/cconeil/Standard-Template-Protocols'
  s.summary  = 'Protocols for your every day iOS needs'
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/cconeil/Standard-Template-Protocols.git', :tag => s.version.to_s }
  s.source_files = 'STP/*{.h,.swift}'
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
end
