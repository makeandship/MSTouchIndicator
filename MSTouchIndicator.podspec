Pod::Spec.new do |s|
  s.name             = "MSTouchIndicator"
  s.version          = "0.1.1"
  s.summary          = "Show touch interactions in your app in realtime, for screen recordings or demos"
  s.description      = <<-DESC
                       Simple library for indicating touches in your app. Great for making sceen recordings or running demos.
                       DESC
  s.homepage         = "https://github.com/makeandship/MSTouchIndicator"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Simon Heys" => "simon@makeandship.co.uk" }
  s.source           = { :git => "https://github.com/makeandship/MSTouchIndicator.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/makeandship'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MSTouchIndicator' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
