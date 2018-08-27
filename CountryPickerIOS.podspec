
Pod::Spec.new do |s|

  s.name         = "CountryPickerIOS"
  s.version      = "1.0.2"
  s.summary      = "Lighweight CountryPicker for IOS apps."
  s.description  = "CountryPicker with ISO country codes and international phone number formats."
  s.homepage     = "https://github.com/yehorchernenko/CountryPickerIOS"
  s.license      = "MIT"
  s.author       = { "Yehor Chernenko" => "lordo916@gmail.com" }
  s.swift_version = "4.1"
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/yehorchernenko/CountryPickerIOS.git", :tag => "1.0.2" }
  s.source_files  = "CountryPickerView/Classes/**"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.resources = "CountryPickerView/Resources/**"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"


end
