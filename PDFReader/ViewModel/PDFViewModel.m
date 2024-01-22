//
//  PDFViewModel.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFViewModel.h"

@interface PDFViewModel ()

@property (strong, nonatomic) id<PDFServiceProtocol> service;

@end

@implementation PDFViewModel

- (instancetype)initWithService:(id<PDFServiceProtocol>)service{
    if(self == [super init]){
        _service = service;
    }
    return self;
}


- (void)getDocuments{
    __typeof(self) __weak weakSelf = self;
    [_service getDocuments:^(NSArray<PDFModel *> * _Nullable documents, NSError * _Nullable error) {
        if(documents != Nil){
            [weakSelf.delegate getDocuments:documents];
        }
    }];

}

- (void)saveDocument:(NSURL *)url{
    __typeof(self) __weak weakSelf = self;
    [_service saveDocument:url success:^(NSError * _Nullable error) {
        if(error == Nil){
            [weakSelf getDocuments];
        }
    }];
}

- (void)deleteDocument:(NSURL *)url{
    __typeof(self) __weak weakSelf = self;
    [_service deleteDocument:url success:^(NSError * _Nullable error) {
        if(error == Nil){
            [weakSelf getDocuments];
        }
    }];

}

@end
