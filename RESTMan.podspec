Pod::Spec.new do |s|

  s.name         = "RESTMan"

  s.version      = "0.0.1"

  s.summary      = "Clean, maintainable iOS networking framework."

  s.description  = <<-DESC
                   RESTMan lets you easily interact with RESTful (GET, POST, PUT, DELETE) web APIs by allowing you to reference objects instead of URLs within your code. No messy in-line URLs to maintain.
                   DESC

  s.homepage     = "https://github.com/camclendenin/RESTMan"

  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  # s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author    = "camclendenin"

  # s.social_media_url   = "http://twitter.com/?"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/camclendenin/RESTMan.git", :tag => "0.0.1" }

  s.source_files  = "RESTMan/*""
  
  s.dependency "AFNetworking", "~> 2.0"

end
