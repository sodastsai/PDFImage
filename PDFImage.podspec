Pod::Spec.new do |s|

  s.name         = "PDFImage"
  s.version      = "0.2.0"
  s.summary      = "Render PDF files into UIImage"
  s.description  = "A simple utility to help you render PDF files into UIImage."
  s.homepage     = "https://github.com/sodastsai/PDFImage"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "sodas tsai" => "sodas2002@gmail.com" }

  s.platform     = :ios, "8.0"
  s.source       = {:git => "https://github.com/sodastsai/PDFImage.git", :tag => "v#{s.version.to_s}"}
  s.source_files = "PDFImage", "PDFImage/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation", "CoreGraphics"
  s.requires_arc = true
  s.xcconfig     = { "OTHER_LDFLAGS" => "-ObjC" }
  s.public_header_files  = "PDFImage/*.h"
  s.private_header_files = "PDFImage/*_Internal.h"

end
