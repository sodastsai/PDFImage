//
//  PIPDFPage.m
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
