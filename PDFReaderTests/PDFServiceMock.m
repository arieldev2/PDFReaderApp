//
//  PDFServiceMock.m
//  PDFReaderTests
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import "PDFServiceMock.h"

@implementation PDFServiceMock

+ (nonnull id)sharedService {
    static PDFServiceMock *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

- (void)getDocuments:(nonnull void (^)(NSArray<PDFModel *> * _Nullable, NSError * _Nullable))completion {
    NSMutableArray<PDFModel *> * docs = [[NSMutableArray<PDFModel *> alloc] initWithArray: @[
        [[PDFModel alloc] initWithID:[[NSUUID alloc] init] title:@"doc 1" path:@"doc1url"], [[PDFModel alloc] initWithID:[[NSUUID alloc] init]  title:@"doc 2" path:@"doc2url"], [[PDFModel alloc] initWithID:[[NSUUID alloc] init]  title:@"doc 3" path:@"doc3url"], [[PDFModel alloc] initWithID:[[NSUUID alloc] init]  title:@"doc 4" path:@"doc4url"]
    ]];
    completion(docs, Nil);
}

- (void)saveDocument:(nonnull NSURL *)url success:(nonnull void (^)(NSError * _Nullable))completion {
    completion(Nil);
}

- (void)deleteDocument:(nonnull NSURL *)url success:(nonnull void (^)(NSError * _Nullable))completion { 
    completion(Nil);
}

@end
