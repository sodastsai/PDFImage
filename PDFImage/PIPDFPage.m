//
//  PIPDFPage.m
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

#import "PIPDFPage_Internal.h"
#import "UIImage+PDFImage.h"

@interface PIPDFPage ()

@property (nonatomic, assign, readwrite) CGPDFPageRef CGPDFPage;

@end

@implementation PIPDFPage

- (instancetype)init {
    return [self initWithCGPDFPageRef:nil];
}

- (instancetype)initWithCGPDFPageRef:(CGPDFPageRef)pdfPageRef {
    if (!pdfPageRef) {
        return self = nil;
    }
    if (self = [super init]) {
        _CGPDFPage = CGPDFPageRetain(pdfPageRef);
    }
    return self;
}

- (void)dealloc {
    if (_CGPDFPage) {
        CGPDFPageRelease(_CGPDFPage);
        _CGPDFPage = NULL;
    }
}

#pragma mark - Method

- (CGRect)rectOfPDFBox:(PIPDFBox)pdfBox {
    return CGPDFPageGetBoxRect(self.CGPDFPage, (CGPDFBox)pdfBox);
}

- (UIImage *)image {
    return UIImageFromCGPDFPageRef(self.CGPDFPage, kCGPDFCropBox, 1.);
}

- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox {
    return UIImageFromCGPDFPageRef(self.CGPDFPage, (CGPDFBox)pdfBox, 1.);
}

- (UIImage *)imageOfPDFBox:(PIPDFBox)pdfBox scale:(CGFloat)scale {
    return UIImageFromCGPDFPageRef(self.CGPDFPage, (CGPDFBox)pdfBox, scale);
}

@end
