//
//  PIPDFPage.m
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import "PIPDFPage_Internal.h"
#import "UIImage+PDFImage.h"

@interface PIPDFPage () {
    CGPDFPageRef _pdfPage;
}

@end

@implementation PIPDFPage

- (instancetype)initWithCGPDFPageRef:(CGPDFPageRef)pdfPageRef {
    if (self = [super init]) {
        _pdfPage = CGPDFPageRetain(pdfPageRef);
    }
    return self;
}

- (void)dealloc {
    if (_pdfPage) {
        CGPDFPageRelease(_pdfPage), _pdfPage = NULL;
    }
}

#pragma mark - Method

- (CGRect)rectOfPDFBox:(PIPDFBox)pdfBox {
    return CGPDFPageGetBoxRect(_pdfPage, (CGPDFBox)pdfBox);
}

- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox {
    return [self imageOfPDFBox:pdfBox scale:1.];
}

- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox scale:(CGFloat)scale {
    return UIImageFromCGPDFPageRef(_pdfPage, (CGPDFBox)pdfBox, scale);
}

@end
