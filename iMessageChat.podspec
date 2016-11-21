Pod::Spec.new do |s|
 
  # 1
  s.platform = :ios
  s.ios.deployment_target = '9.3'
  s.name = "iMessageChat"
  s.summary = "iMessageChat lets a user select an ice cream flavor."
  s.requires_arc = true
 
  # 2
  s.version = "0.1.0"
 
  # 3
  s.license = { :type => "MIT", :file => "LICENSE" }
 
  # 4 - Replace with your name and e-mail address
  s.author = { "Ugo Marinelli" => "ugo.marinelli@fr.ibm.com" }
 
  # For example,
  # s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }
 
 
  # 5 - Replace this URL with your own Github page's URL (from the address bar)
  s.homepage = "https://github.com/ugomarinelli/iMessageChat.git"
 
  # For example,
  # s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"
 
 
  # 6 - Replace this URL with your own Git URL from "Quick Setup"
  s.source = { :git => "https://github.com/ugomarinelli/iMessageChat.git", :tag => "#{s.version}"}
 
  # For example,
  # s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}
 

  # 7
  s.framework = "UIKit"
  s.dependency 'IQKeyboardManagerSwift'

 
  # 8
  s.source_files = "iMessageChat/**/*.{swift}"
 
  # 9
  s.resources = "iMessageChat/**/*.{png,jpeg,jpg,storyboard,xib}"
end