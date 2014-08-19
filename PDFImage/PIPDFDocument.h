//
//  PIPDFDocument.h
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PIPDFPage;

@interface PIPDFDocument : NSObject

+ (instancetype)PDFDocumentWithContentsOfURL:(NSURL *)url;
+ (instancetype)PDFDocumentWithContentsOfFile:(NSString *)path;
+ (instancetype)PDFDocumentWithData:(NSData *)data;

- (instancetype)initWithContentsOfURL:(NSURL *)url;
- (instancetype)initWithContentsOfFile:(NSString *)path;
- (instancetype)initWithData:(NSData *)data;

@property(nonatomic, assign, readonly) NSUInteger numberOfPages;

- (PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber;

@end
