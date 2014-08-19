//
//  PIPDFPage_Internal.h
//  PDFImage
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import "PIPDFPage.h"
#import <CoreGraphics/CoreGraphics.h>

@interface PIPDFPage ()

- (instancetype)initWithCGPDFPageRef:(CGPDFPageRef)pdfPageRef;

@end
