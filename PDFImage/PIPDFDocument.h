//
//  PIPDFDocument.h
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

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <PDFImage/PIUtilities.h>

@class PIPDFPage;

NS_ASSUME_NONNULL_BEGIN

@interface PIPDFDocument : NSObject

@property (nonatomic, assign, readonly) CGPDFDocumentRef CGPDFDocument;

+ (nullable instancetype)PDFDocumentWithContentsOfURL:(nullable NSURL *)url;
+ (nullable instancetype)PDFDocumentWithContentsOfFile:(nullable NSString *)path;
+ (nullable instancetype)PDFDocumentWithData:(NSData *)data;

- (nullable instancetype)initWithContentsOfURL:(nullable NSURL *)url;
- (nullable instancetype)initWithContentsOfFile:(nullable NSString *)path;
- (nullable instancetype)initWithData:(NSData *)data;
- (nullable instancetype)initWithCGPDFDocument:(CGPDFDocumentRef)pdfDocumentRef NS_DESIGNATED_INITIALIZER;

@property (readonly) NSUInteger numberOfPages;
- (PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber;
- (PIPDFPage *)objectAtIndexedSubscript:(NSUInteger)idx;

@property (readonly) NSEnumerator PIGenerics(PIPDFPage *) *pageEnumerator;

@end

NS_ASSUME_NONNULL_END
