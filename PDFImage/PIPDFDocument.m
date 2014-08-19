//
//  PIPDFDocument.m
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import "PIPDFDocument.h"
#import "PIPDFPage_Internal.h"
#import <CoreGraphics/CoreGraphics.h>

@interface PIPDFDocument () {
    CGPDFDocumentRef _pdfDocument;
}

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

@end
