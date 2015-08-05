//
//  UIImage+PDFImage.h
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

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

extern UIImage *UIImageFromCGPDFPageRef(CGPDFPageRef pdfPage, CGPDFBox pdfBox, CGFloat scale);
extern CGImageRef CGPDFPageCreateImage(CGPDFPageRef pdfPage, CGPDFBox pdfBox, CGFloat scale) CF_RETURNS_RETAINED;

@interface UIImage (PDFImage)

+ (NSData *)dataOfPDFContentsWithImages:(NSArray *)images;

+ (nullable instancetype)imageWithContentsOfPDFFile:(nullable NSString *)path;

+ (nullable instancetype)imageWithContentsOfPDFFile:(nullable NSString *)path scale:(CGFloat)scale;

+ (nullable instancetype)imageWithContentsOfPDFFile:(nullable NSString *)path
                                               page:(NSUInteger)pageNumber
                                             pdfBox:(CGPDFBox)pdfBox
                                              scale:(CGFloat)scale;

+ (nullable instancetype)imageWithContentsOfPDFURL:(nullable NSURL *)url;

+ (nullable instancetype)imageWithContentsOfPDFURL:(nullable NSURL *)url scale:(CGFloat)scale;

+ (nullable instancetype)imageWithContentsOfPDFURL:(nullable NSURL *)url
                                              page:(NSUInteger)pageNumber
                                            pdfBox:(CGPDFBox)pdfBox
                                             scale:(CGFloat)scale;

+ (nullable instancetype)imageWithContentsOfPDFData:(NSData *)data;

+ (nullable instancetype)imageWithContentsOfPDFData:(NSData *)data
                                              scale:(CGFloat)scale;

+ (nullable instancetype)imageWithContentsOfPDFData:(NSData *)data
                                               page:(NSUInteger)pageNumber
                                             pdfBox:(CGPDFBox)pdfBox
                                              scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
