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

extern UIImage *UIImageFromCGPDFPageRef(CGPDFPageRef pdfPage, CGPDFBox pdfBox, CGFloat scale);
extern CGImageRef CGPDFPageCreateImage(CGPDFPageRef pdfPage, CGPDFBox pdfBox, CGFloat scale);

@interface UIImage (PDFImage)

+ (NSData *)dataOfPDFContentsWithImages:(NSArray *)images;

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path;

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                     scale:(CGFloat)scale;

+ (instancetype)imageWithContentsOfPDFFile:(NSString *)path
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale;

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url;

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                    scale:(CGFloat)scale;

+ (instancetype)imageWithContentsOfPDFURL:(NSURL *)url
                                     page:(NSUInteger)pageNumber
                                   pdfBox:(CGPDFBox)pdfBox
                                    scale:(CGFloat)scale;

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data;

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                     scale:(CGFloat)scale;

+ (instancetype)imageWithContentsOfPDFData:(NSData *)data
                                      page:(NSUInteger)pageNumber
                                    pdfBox:(CGPDFBox)pdfBox
                                     scale:(CGFloat)scale;

@end
