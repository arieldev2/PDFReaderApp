//
//  PDFPageIndicatorUIView.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFPageIndicatorUIView : UIView

- (void)configure:(NSInteger)totalPages currentPage:(NSInteger)currentPage;

@end

NS_ASSUME_NONNULL_END
