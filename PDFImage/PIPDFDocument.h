//
//  PIPDFDocument.h
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

@class PIPDFPage;

NS_ASSUME_NONNULL_BEGIN

@interface PIPDFDocument : NSObject

@property (nonatomic, assign, readonly) CGPDFDocumentRef CGPDFDocument;

+ (nullable instancetype)PDFDocumentWithContentsOfURL:(nullable NSURL *)url;
+ (nullable instancetype)PDFDocumentWithContentsOfFile:(nullable NSString *)path;
+ (nullable instancetype)PDFDocumentWithData:(NSData *)data;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithContentsOfURL:(nullable NSURL *)url;
- (nullable instancetype)initWithContentsOfFile:(nullable NSString *)path;
- (nullable instancetype)initWithData:(NSData *)data;
- (nullable instancetype)initWithCGPDFDocument:(CGPDFDocumentRef)pdfDocument
    NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(pdfDocument:));

@property (readonly) NSUInteger numberOfPages;
- (nullable PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber NS_SWIFT_NAME(page(at:));
- (PIPDFPage *)objectAtIndexedSubscript:(NSUInteger)idx;

@property (readonly) NSEnumerator<PIPDFPage *> *pageEnumerator;

@end

NS_ASSUME_NONNULL_END
