//
//  PIPDFDocument.m
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

#import "PIPDFDocument.h"
#import "PIPDFPage_Internal.h"
#import <CoreGraphics/CoreGraphics.h>

@interface PIPDFDocumentPageEnumerator : NSEnumerator {
    PIPDFDocument *_pdfDocument;

    NSInteger pdfPageCount;
    NSInteger currentPageIndex;
}

- (instancetype)initWithPDFDocument:(PIPDFDocument *)document;

@end

@interface PIPDFDocument ()

@property(nonatomic, assign, readonly) CGPDFDocumentRef pdfDocument;

@end

@implementation PIPDFDocument

+ (instancetype)PDFDocumentWithContentsOfURL:(NSURL *)url {
    return [[self alloc] initWithContentsOfURL:url];
}

+ (instancetype)PDFDocumentWithContentsOfFile:(NSString *)path {
    return [[self alloc] initWithContentsOfFile:path];
}

+ (instancetype)PDFDocumentWithData:(NSData *)data {
    return [[self alloc] initWithData:data];
}

- (instancetype)initWithContentsOfURL:(NSURL *)url {
    if (self = [super init]) {
        _pdfDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    }
    return self;
}

- (instancetype)initWithContentsOfFile:(NSString *)path {
    return [self initWithContentsOfURL:[NSURL fileURLWithPath:path]];
}

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
        _pdfDocument = CGPDFDocumentCreateWithProvider(dataProvider);
        CGDataProviderRelease(dataProvider);
    }
    return self;
}

- (void)dealloc {
    if (_pdfDocument) {
        CGPDFDocumentRelease(_pdfDocument), _pdfDocument = NULL;
    }
}

#pragma mark - Pages

- (NSUInteger)numberOfPages {
    return CGPDFDocumentGetNumberOfPages(_pdfDocument);
}

- (PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber {
    CGPDFPageRef pdfPage = CGPDFDocumentGetPage(_pdfDocument, pageNumber);
    if (pdfPage) {
        return [[PIPDFPage alloc] initWithCGPDFPageRef:pdfPage];
    }
    return nil;
}

- (NSEnumerator *)pageEnumerator {
    return [[PIPDFDocumentPageEnumerator alloc] initWithPDFDocument:self];
}

@end

@implementation PIPDFDocumentPageEnumerator

- (instancetype)initWithPDFDocument:(PIPDFDocument *)document {
    if (self = [super init]) {
        currentPageIndex = 1;
        _pdfDocument = document;
        pdfPageCount = _pdfDocument.numberOfPages;
    }
    return self;
}

- (id)nextObject {
    if (currentPageIndex > pdfPageCount) {
        return nil;
    } else {
        return [_pdfDocument pageAtPageNumber:currentPageIndex++];
    }
}

@end
