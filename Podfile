# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_modular_headers!

target 'apduKit' do
	inherit! :search_paths
	project 'apduKit.xcodeproj'
	workspace 'apduKit.xcworkspace'
	podspec

    target 'apduKitTests' do
        inherit! :search_paths
        pod "Cuckoo"
    end
end

target 'Example' do
    inherit! :search_paths
    project 'Example.xcodeprojx'
    pod "apduKit", :path => './'
end
