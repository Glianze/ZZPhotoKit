Pod::Spec.new do |s|
s.name = 'ZZPhotoKit'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'Photokit'
s.homepage = 'https://github.com/ACEYL/ZZPhotoKit'
s.authors = { 'migic_z' => 'zaizaiyl520@126.com' }
s.source = { :git => 'https://github.com/ACEYL/ZZPhotoKit.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'ZZPhotoKit/ZZPhotoKit/*.{h,m}'
end