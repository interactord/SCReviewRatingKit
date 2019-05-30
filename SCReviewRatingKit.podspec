Pod::Spec.new do |s|
    s.name         = "SCReviewRatingKit"
    s.version      = "1.0.0"
    s.summary      = "SCReviewRatingKit is make rating controll event view"
    s.description  = <<-DESC
    SCReviewRatingKit aim to
  * Chainning property Attributes
                     DESC
  
    s.homepage     = "https://github.com/interactord/SCReviewRatingKit"
    s.license      = { :type => "MIT", :file => "LICENSE.md" }
    s.authors      = { "Scoon Moon" => "interactord@gmail.com" }
    s.platform     = :ios
    s.platform     = :ios, "12.2"
    s.swift_version = '5.0'
    s.pod_target_xcconfig = {
      'SWIFT_VERSION' => '5.0'
    }
    s.source       = { :git => "https://github.com/interactord/SCReviewRatingKit.git", :tag => s.version.to_s }
    s.default_subspec = 'Core'
    

    s.subspec "Core" do |ss|
        ss.source_files = "Source/SCReviewRatingKit/*.swift"
        ss.framework = 'UIKit', 'Foundation'
    end

    s.subspec "RxSwift" do |ss|
        ss.source_files = "Source/RxSCReviewRatingKit/*.swift"
        ss.dependency "RxSwift", "~> 5"
        ss.dependency "RxCocoa", "~> 5"
        ss.framework = "UIKit", "Foundation"
    end
  
  end