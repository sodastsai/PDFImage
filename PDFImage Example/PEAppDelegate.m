//
//  PEAppDelegate.m
//  PDFImage Example
//
//  Created by sodas on 8/19/14.
//  Copyright (c) 2014 sodas. All rights reserved.
//

#import "PEAppDelegate.h"
#import <PDFImage/PDFImage.h>

@implementation PEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    PIPDFDocument *pdfDocument = [PIPDFDocument
                                  PDFDocumentWithContentsOfFile:@"/Users/sodas/Downloads/b1-sprite/8bit Orca.pdf"];
    for (PIPDFPage *pdfPage in [pdfDocument pageEnumerator]) {
        NSLog(@"%@", NSStringFromCGRect([pdfPage rectOfPDFBox:PIPDFCropBox]));
    }

    return YES;
}

@end
