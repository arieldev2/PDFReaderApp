//
//  PDFViewModel.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <Foundation/Foundation.h>
#import "PDFModel.h"
#import "PDFService.h"
#import "PDFViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface PDFViewModel : NSObject <PDFViewModelProtocol>

- (instancetype)initWithService:(id<PDFServiceProtocol>)service;

- (void)getDocuments;
- (void)saveDocument:(NSURL *)url;
- (void)deleteDocument:(NSURL *)url;

@property(weak, nonatomic) id<PDFViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
