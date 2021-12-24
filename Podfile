# Uncomment the next line to define a global platform for your project
platform :ios, "13.0"

target "MoviesApp" do
  # Comment the next line if you"re not using Swift and don"t want to use dynamic frameworks
  use_frameworks!

  # Pods for MoviesApp
  pod "Alamofire", "4.5"
  pod "DefaultsKit", "0.2"
  pod "RealmSwift", "3.19.0"
  pod "SDWebImage", "4.0"

  target "MoviesAppTests" do
    inherit! :search_paths
    # Pods for MoviesApp
  end

end

target "MoviesAppUITests" do
    use_frameworks!
    inherit! :search_paths
    # Pods for testing
end

# pod "FacebookSDK", "6.5.1"
target "MoviesAppMockTesting" do
    use_frameworks!
    # Pods for testing
    pod "Alamofire", "4.5"
    pod "DefaultsKit", "0.2"
    pod "RealmSwift", "3.19.0"
    pod "SDWebImage", "4.0"
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["DEBUG_INFORMATION_FORMAT"] = "dwarf"
      config.build_settings.delete "IPHONEOS_DEPLOYMENT_TARGET"
      config.build_settings["ONLY_ACTIVE_ARCH"] = "YES"
    end
    if target.name == "Spreedly" || target.name == "Bugle"
      target.build_configurations.each do |config|
        config.build_settings["SWIFT_VERSION"] = "4.0"
      end
    elsif target.name == "Alamofire"
      target.build_configurations.each do |config|
        config.build_settings["SWIFT_VERSION"] = "4.2"
      end
    else
      target.build_configurations.each do |config|
        config.build_settings["SWIFT_VERSION"] = "5.0"
      end
    end
  end
end
