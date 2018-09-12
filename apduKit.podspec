#
# Be sure to run `pod lib lint apduKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'apduKit'
  s.version          = '1.0.0'
  s.summary          = 'ApduKit contains all the objects you need to parse, build and interpret APDU messages'

  s.description      = <<-DESC
  You can use the Apdu developer kit to build and parse apdu messages. The SDK also exposes interpret layers that can be used to emulate a smart card.
                       DESC

  s.homepage         = 'https://git.ul-ts.com/sl-advisory/RDW/swift-apdukit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'UL-Transactions' => 'transactionsecurity@ul.com' }
  s.source           = { :git => 'ssh://git@git.ul-ts.com:5022/sl-advisory/RDW/swift-apdukit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '3.2'

  s.source_files = 'apduKit/**/*'
  s.dependency 'Promises', '~> 2.0.1'
end
