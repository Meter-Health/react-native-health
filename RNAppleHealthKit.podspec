require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name             = 'RNAppleHealthKit'
  s.version          = package['version']
  s.summary          = package['description']
  s.description      = <<-DESC
A React Native package to interact with Apple HealthKit
                       DESC

  s.homepage         = 'https://github.com/Meter-Health/react-native-health'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Agency Enterprise' => '' }
  s.source           = { :git => 'https://github.com/Meter-Health/react-native-health.git', :tag => s.version.to_s }

  s.platforms        = { :ios => '15.1' }

  s.source_files     = 'RCTAppleHealthKit/**/*.{h,m,mm}'
  s.frameworks       = ['HealthKit']

  # Expose the pod as a module so Swift AppDelegates can `import RNAppleHealthKit`
  # to call initializeBackgroundObservers().
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  if respond_to?(:install_modules_dependencies, true)
    # RN >= 0.71: pulls in React-Core plus, when the New Architecture is on, the
    # codegen / TurboModule dependencies and the RCT_NEW_ARCH_ENABLED flag.
    install_modules_dependencies(s)
  else
    s.dependency 'React-Core'
  end
end
