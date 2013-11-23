Pod::Spec.new do |s|
  s.name         = "ADN"
  s.version      = "0.0.1"
  s.summary      = "Project will suggest list applications for downloading. If user want to get it, please download app on device."

  s.description  = <<-DESC
                   A longer description of ADN in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/lengocduy/ADN"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "lengocduy" => "duyln@vng.com.vn" }
  s.platform     = :ios, '5.0'
  s.source       = { :git => "https://github.com/lengocduy/ADN.git", :commit => "ff76852818759a2f0caea6ad28b5feef17299fc9" }
  s.source_files  = 'ADN/*.{h,m}'
  s.requires_arc = true
end
