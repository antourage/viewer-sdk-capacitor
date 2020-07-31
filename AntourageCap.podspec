
  Pod::Spec.new do |s|
    s.name = 'AntourageCap'
    s.version = '0.0.5'
    s.summary = 'Antourage widget plugin'
    s.license = 'MIT'
    s.homepage = 'https://github.com/antourage/AntViewer_capacitor.git'
    s.author = 'mv@leobit.com'
    s.source = { :git => 'https://github.com/antourage/AntViewer_capacitor.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.3'
    s.platform     = :ios, "11.3"
    s.static_framework = true
    s.dependency 'Capacitor'
    s.dependency 'Antourage', '~> 2.0.11'
  end