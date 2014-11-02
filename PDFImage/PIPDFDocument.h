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

@class PIPDFPage;

@interface PIPDFDocument : NSObject

@property(nonatomic, assign, readonly) CGPDFDocumentRef CGPDFDocument;

+ (instancetype)PDFDocumentWithContentsOfURL:(NSURL *)url;
+ (instancetype)PDFDocumentWithContentsOfFile:(NSString *)path;
+ (instancetype)PDFDocumentWithData:(NSData *)data;

- (instancetype)initWithContentsOfURL:(NSURL *)url;
- (instancetype)initWithContentsOfFile:(NSString *)path;
- (instancetype)initWithData:(NSData *)data;

@property(nonatomic, assign, readonly) NSUInteger numberOfPages;
- (PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber;

- (NSEnumerator *)pageEnumerator;

@end
