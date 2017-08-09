//
//  PIPDFPage.h
//  PDFImage
//
/*
 Copyright 2014-2017 Tien-Che Tsai (@sodastsai).

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

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

NS_ASSUME_NONNULL_BEGIN

@interface PIPDFPage : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init;

@property (nonatomic, assign, readonly) CGPDFPageRef CGPDFPage;

- (CGRect)rectOfPDFBox:(PIPDFBox)pdfBox;

@property (readonly) UIImage *image;
- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox;
- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
