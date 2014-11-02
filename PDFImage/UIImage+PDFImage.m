//
//  UIImage+PDFImage.m
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//
/*
 Copyright 2014 sodastsai.

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

#import "UIImage+PDFImage.h"
#import "PIPDFDocument.h"
#import "PIPDFPage.h"

UIImage *UIImageFromCGPDFPageRef(CGPDFPageRef pdfPage,
                                 CGPDFBox pdfBox,
                                 CGFloat scale) {
    // Calc image size
    CGRect pdfRect = CGPDFPageGetBoxRect(pdfPage, pdfBox);
    CGSize canvasSize = CGSizeMake(pdfRect.size.width * scale,
                                   pdfRect.size.height * scale);
    // Setup context
    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, 0.);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Make CGContextRef fit to UIKit
    CGContextTranslateCTM(context, 0.0, canvasSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // Setup image location
    CGContextTranslateCTM(context, -pdfRect.origin.x, -pdfRect.origin.y);
    // Setup scale and draw
    CGContextScaleCTM(context, scale, scale);
    CGContextDrawPDFPage(context, pdfPage);
    // Get image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // Close context
    UIGraphicsEndImageContext();
    // Return image
    return image;
}

@implementation UIImage (PDFImage)

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path {
    return [[[PIPDFDocument PDFDocumentWithContentsOfFile:path] pageAtPageNumber:1]
            imageOfPDFBox:PIPDFCropBox
            scale:1.];
}

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                     scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithContentsOfFile:path] pageAtPageNumber:1]
            imageOfPDFBox:PIPDFCropBox
            scale:scale];
}

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithContentsOfFile:path] pageAtPageNumber:pageNumber]
            imageOfPDFBox:(PIPDFBox)pdfBox
            scale:scale];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url {
    return [[[PIPDFDocument PDFDocumentWithContentsOfURL:url] pageAtPageNumber:1] imageOfPDFBox:PIPDFCropBox scale:1.];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                    scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithContentsOfURL:url] pageAtPageNumber:1]
            imageOfPDFBox:PIPDFCropBox
            scale:scale];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                     page:(NSUInteger)pageNumber
                                   pdfBox:(CGPDFBox)pdfBox
                                    scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithContentsOfURL:url] pageAtPageNumber:pageNumber]
            imageOfPDFBox:(PIPDFBox)pdfBox
            scale:scale];
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data {
    return [[[PIPDFDocument PDFDocumentWithData:data] pageAtPageNumber:1] imageOfPDFBox:PIPDFCropBox scale:1.];
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                     scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithData:data] pageAtPageNumber:1] imageOfPDFBox:PIPDFCropBox scale:scale];
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale {
    return [[[PIPDFDocument PDFDocumentWithData:data] pageAtPageNumber:pageNumber]
            imageOfPDFBox:(PIPDFBox)pdfBox
            scale:scale];
}

@end
