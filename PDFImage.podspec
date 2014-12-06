Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "PDFImage"
  s.version      = "0.0.7"
  s.summary      = "Render PDF files into UIImage"
  s.description  = "A simple utility to help you render PDF files into UIImage."
  s.homepage     = "https://github.com/sodastsai/PDFImage"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = "Apache License, Version 2.0"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "sodas tsai" => "sodas2002@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios
  s.platform     = :ios, "4.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = {
   :git => "https://github.com/sodastsai/PDFImage.git",
   :tag => "v0.0.7"
  }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "PDFImage", "PDFImage/*.{h,m}"

  s.public_header_files = "PDFImage/PDFImage.h", "PDFImage/PIPDFDocument.h",
                          "PDFImage/PIPDFPage.h", "PDFImage/UIImage+PDFImage.h"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.frameworks = "UIKit", "Foundation", "CoreGraphics"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true
  s.xcconfig = { "OTHER_LDFLAGS" => "-ObjC" }

end
