//
//  PDFViewModel.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <Foundation/Foundation.h>
#import "PDFModel.h"
#import "PDFService.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PDFViewModelDelegate <NSObject>
- (void)getDocuments:(NSArray<PDFModel *> *)documents;
@end

@interface PDFViewModel : NSObject

- (instancetype)initWithService:(id<PDFServiceProtocol>)service;

- (void)getDocuments;
- (void)saveDocument:(NSURL *)url;
- (void)deleteDocument:(NSURL *)url;

@property(weak, nonatomic) id<PDFViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
