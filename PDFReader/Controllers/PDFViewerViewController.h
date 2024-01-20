//
//  PDFViewerViewController.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>
#import "PDFModel.h"
#import "PDFPageIndicatorUIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDFViewerViewController : UIViewController

- (instancetype)initWithDocument:(PDFModel *)model;

@end

NS_ASSUME_NONNULL_END
