//
//  PDFModel.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFModel.h"

@implementation PDFModel

- (instancetype)initWithID:(NSUUID *)id title:(NSString *)title path:(NSString *)path{
    if(self == [super init]){
        _id = id;
        _title = title;
        _path = path;
    }
    return self;
}

@end
