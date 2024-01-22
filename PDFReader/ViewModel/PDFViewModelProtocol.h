//
//  PDFViewModelProtocol.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import <Foundation/Foundation.h>
#import "PDFService.h"
#import "PDFModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol PDFViewModelDelegate <NSObject>
- (void)getDocuments:(NSArray<PDFModel *> *)documents;
- (void)saveDocument:(NSError * )error;
- (void)deleteDocument:(NSError * )error;
@end

@protocol PDFViewModelProtocol <NSObject>

- (instancetype  )initWithService:(id<PDFServiceProtocol>)service;

- (void)getDocuments;
- (void)saveDocument:(NSURL *)url;
- (void)deleteDocument:(NSURL *)url;

@property(weak, nonatomic) id<PDFViewModelDelegate>  delegate;

@end

NS_ASSUME_NONNULL_END
