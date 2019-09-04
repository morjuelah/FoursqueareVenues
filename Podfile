# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
inhibit_all_warnings!
  
def shared_pods
    use_frameworks!
    
    pod 'Alamofire'
    pod 'SDWebImage'
    pod 'Pulley'
end

target 'FoursqueareVenues' do
  shared_pods
end

target 'FoursqueareVenuesTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'FoursqueareVenuesUITests' do
  inherit! :search_paths
  # Pods for testing
end
