//
//  PDFErrors.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ErrorCaseType) {
    FailedGetDocuments,
    FailedSaveDocument,
    FailedDeleteDocument
};


@interface NSError (PDFErrors)

+ (NSError *)setError:(ErrorCaseType)error;

@end

NS_ASSUME_NONNULL_END
