//
//  PDFServiceMock.h
//  PDFReaderTests
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import <Foundation/Foundation.h>
#import "PDFServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDFServiceMock : NSObject <PDFServiceProtocol>

+ (id)sharedService;

- (void)getDocuments:(void (^)( NSArray<PDFModel *> * _Nullable documents, NSError * _Nullable error))completion;
- (void)saveDocument:(NSURL *)url success:(void (^)( NSError * _Nullable error))completion;
- (void)deleteDocument:(NSURL *)url success:(void (^)( NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
