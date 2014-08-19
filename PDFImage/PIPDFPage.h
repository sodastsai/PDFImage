//
//  PIPDFPage.h
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PIPDFBox) {
    PIPDFMediaBox = kCGPDFMediaBox,
    PIPDFCropBox = kCGPDFCropBox,
    PIPDFBleedBox = kCGPDFBleedBox,
    PIPDFTrimBox = kCGPDFTrimBox,
    PIPDFArtBox = kCGPDFArtBox,
};

@interface PIPDFPage : NSObject

- (CGRect)rectOfPDFBox:(PIPDFBox)pdfBox;
- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox;
- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox scale:(CGFloat)scale;

@end
