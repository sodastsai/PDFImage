//
//  UIImage+PDFImage.m
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import "UIImage+PDFImage.h"

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
    return [self imageWithContentsOfPDFURL:[NSURL fileURLWithPath:path]
                                      page:1
                                    pdfBox:kCGPDFCropBox
                                     scale:1.];
}

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                     scale:(CGFloat)scale {
    return [self imageWithContentsOfPDFURL:[NSURL fileURLWithPath:path]
                                      page:1
                                    pdfBox:kCGPDFCropBox
                                     scale:scale];
}

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale {
    return [self imageWithContentsOfPDFURL:[NSURL fileURLWithPath:path]
                                      page:pageNumber
                                    pdfBox:pdfBox
                                     scale:scale];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url {
    return [self imageWithContentsOfPDFURL:url page:1 pdfBox:kCGPDFCropBox scale:1.];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                    scale:(CGFloat)scale {
    return [self imageWithContentsOfPDFURL:url page:1 pdfBox:kCGPDFCropBox scale:scale];
}

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                     page:(NSUInteger)pageNumber
                                   pdfBox:(CGPDFBox)pdfBox
                                    scale:(CGFloat)scale {
    UIImage *result = nil;
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    CGPDFPageRef pdfPage = CGPDFDocumentGetPage(pdfDocument, pageNumber);
    if (pdfPage) {
        result = UIImageFromCGPDFPageRef(pdfPage, pdfBox, scale);
    }
    CGPDFDocumentRelease(pdfDocument);
    return result;
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data {
    return [self imageWithContentsOfPDFData:data page:1 pdfBox:kCGPDFCropBox scale:1.];
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                     scale:(CGFloat)scale {
    return [self imageWithContentsOfPDFData:data page:1 pdfBox:kCGPDFCropBox scale:scale];
}

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale {
    UIImage *result = nil;
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithProvider(dataProvider);
    CGPDFPageRef pdfPage = CGPDFDocumentGetPage(pdfDocument, pageNumber);
    if (pdfPage) {
        result = UIImageFromCGPDFPageRef(pdfPage, pdfBox, scale);
    }
    CGPDFDocumentRelease(pdfDocument);
    CGDataProviderRelease(dataProvider);
    return result;
}

@end
