//
//  PIPDFDocument.m
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

#import "PIPDFDocument.h"
#import "PIPDFPage_Internal.h"

@interface PIPDFDocumentPageEnumerator : NSEnumerator<PIPDFPage *>

@property (nonatomic, strong) PIPDFDocument *pdfDocument;
@property (nonatomic, assign) NSInteger pdfPageCount;
@property (nonatomic, assign) NSInteger currentPageIndex;

- (instancetype)initWithPDFDocument:(PIPDFDocument *)document;

@end

@interface PIPDFDocument ()

@property (nonatomic, assign, readwrite) CGPDFDocumentRef CGPDFDocument;
@property (nonatomic, readonly, class) NSCache<NSString *, PIPDFPage *> *sharedPageCache;

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

- (instancetype)init {
    return self = [self initWithContentsOfURL:nil];
}

- (instancetype)initWithContentsOfURL:(NSURL *)url {
    if (!url) {
        return self = nil;
    }
    CGPDFDocumentRef _pdfDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
    if (_pdfDocument) {
        self = [self initWithCGPDFDocument:_pdfDocument];
        CGPDFDocumentRelease(_pdfDocument);
        return self;
    } else {
        return self = nil;
    }
}

- (instancetype)initWithContentsOfFile:(NSString *)path {
    if (!path) {
        return self = nil;
    }
    return self = [self initWithContentsOfURL:[NSURL fileURLWithPath:path]];
}

- (instancetype)initWithData:(NSData *)data {
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGPDFDocumentRef _pdfDocument = CGPDFDocumentCreateWithProvider(dataProvider);
    CGDataProviderRelease(dataProvider);

    if (_pdfDocument) {
        self = [self initWithCGPDFDocument:_pdfDocument];
        CGPDFDocumentRelease(_pdfDocument);
        return self;
    } else {
        return self = nil;
    }
}

- (instancetype)initWithCGPDFDocument:(CGPDFDocumentRef)pdfDocumentRef {
    if (self = [super init]) {
        if (pdfDocumentRef) {
            _CGPDFDocument = CGPDFDocumentRetain(pdfDocumentRef);
        } else {
            return self = nil;
        }
    }
    return self;
}

- (void)dealloc {
    if (_CGPDFDocument) {
        CGPDFDocumentRelease(_CGPDFDocument);
        _CGPDFDocument = NULL;
    }
}

#pragma mark - Cache

+ (NSCache<NSString *, PIPDFPage *> *)sharedPageCache {
    static NSCache *sharedPageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPageCache = [[NSCache alloc] init];
        sharedPageCache.countLimit = 30;
    });
    return sharedPageCache;
}

+ (NSString *)cacheForPDFPageAtPageNumber:(NSUInteger)pageNumber inDocument:(PIPDFDocument *)pdfDocument {
    return [NSString stringWithFormat:@"shared-page-cache.doc=%p-page=%ld", pdfDocument, (long)pageNumber];
}

#pragma mark - Pages

- (NSUInteger)numberOfPages {
    return CGPDFDocumentGetNumberOfPages(self.CGPDFDocument);
}

- (PIPDFPage *)pageAtPageNumber:(NSUInteger)pageNumber {
    NSString *cacheKey = [self.class cacheForPDFPageAtPageNumber:pageNumber inDocument:self];
    PIPDFPage *result = [self.class.sharedPageCache objectForKey:cacheKey];
    if (!result) {
        CGPDFPageRef pdfPage = CGPDFDocumentGetPage(self.CGPDFDocument, pageNumber);
        if (pdfPage) {
            result = [[PIPDFPage alloc] initWithCGPDFPageRef:pdfPage];
            [self.class.sharedPageCache setObject:result forKey:cacheKey];
        }
    }
    return result;
}

- (NSEnumerator<PIPDFPage *> *)pageEnumerator {
    return [[PIPDFDocumentPageEnumerator alloc] initWithPDFDocument:self];
}

- (PIPDFPage *)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self pageAtPageNumber:idx];
}

@end

@implementation PIPDFDocumentPageEnumerator

- (instancetype)initWithPDFDocument:(PIPDFDocument *)document {
    if (self = [super init]) {
        _currentPageIndex = 1;
        _pdfDocument = document;
        _pdfPageCount = _pdfDocument.numberOfPages;
    }
    return self;
}

- (id)nextObject {
    if (self.currentPageIndex > self.pdfPageCount) {  // CGPDFDocumentGetPage is 1-based.
        return nil;
    } else {
        return [self.pdfDocument pageAtPageNumber:self.currentPageIndex++];
    }
}

@end
