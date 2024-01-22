//
//  PDFErrors.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import "PDFErrors.h"

@implementation NSError (PDFErrors)

+ (NSError *)setError:(ErrorCaseType)error{
    
    NSString *message;
    
    switch (error) {
        case FailedGetDocuments:
            message = @"Failed to get documents.";
            break;
        case FailedSaveDocument:
            message = @"Failed to save document.";
            break;
        case FailedDeleteDocument:
            message = @"Failed to delete document.";
            break;
        default:
            message = @"";
            break;
    }
    NSError *err = [NSError errorWithDomain:@"error" code:200 userInfo:@{
        NSLocalizedDescriptionKey:message
    }];
    return err;
}

@end
