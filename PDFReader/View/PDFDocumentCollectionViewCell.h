//
//  PDFDocumentCollectionViewCell.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>
#import "PDFModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PDFDocumentCollectionViewCellDelegate <NSObject>
- (void)deletePdf:(NSURL *)url;
@end


@interface PDFDocumentCollectionViewCell : UICollectionViewCell <UIContextMenuInteractionDelegate>

+ (NSString *)identifier;

@property (weak, nonatomic) id<PDFDocumentCollectionViewCellDelegate> delegate;

- (void)configure:(PDFModel *)model;

@end

NS_ASSUME_NONNULL_END
