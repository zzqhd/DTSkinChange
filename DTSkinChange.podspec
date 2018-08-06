
Pod::Spec.new do |s|
  s.name             = 'DTSkinChange'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DTSkinChange.'
  

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zzqhd/DTSkinChange.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '729020128@qq.com' => 'zhuzq@ibuscloud.com' }
  s.source           = { :git => 'https://github.com/zzqhd/DTSkinChange.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.dependency 'AFNetworking' , '~> 2.1'

  s.source_files  = "Classes", "Classes/**/*.{h,m}"


  s.subspec 'ThemeManager' do |d|
    d.source_files = 'DTSkinChange/Classes/ThemeManager/*.{h,m}'
    d.subspec 'RunTimeCategory' do |e|
        e.source_files = 'DTSkinChange/Classes/ThemeManager/RunTimeCategory/*.{h,m}'
    end
  end
  s.subspec 'IconFont' do |d|
    d.source_files = 'DTSkinChange/Classes/IconFont/*.{h,m}'
    end
  s.subspec 'hexColor' do |d|
      d.source_files = 'DTSkinChange/Classes/hexColor/*.{h,m}'
  end
  s.subspec 'NetWorkHelper' do |d|
      d.source_files = 'DTSkinChange/Classes/NetWorkHelper/*.{h,m}'
  end



end
