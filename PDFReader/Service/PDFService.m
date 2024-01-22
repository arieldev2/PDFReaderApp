//
//  PDFService.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import "PDFService.h"

@implementation PDFService

+ (id)sharedService {
    static PDFService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}


- (void)getDocuments:(void (^)(NSArray<PDFModel *> * _Nullable, NSError * _Nullable))completion{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];

    @try {
        NSError *err;
        NSArray<NSString *> *filePaths = [fileManager contentsOfDirectoryAtPath:documentsDirectoryPath error:&err];
        NSMutableArray<PDFModel *> * temp = [[NSMutableArray<PDFModel *> alloc] init];
        for (NSString *path in filePaths) {
            NSString *title = [path stringByDeletingPathExtension].lastPathComponent;
            PDFModel *model = PDFModel.new;
            model.id = [[NSUUID alloc] init];
            model.title = title;
            model.path = [NSString stringWithFormat:@"%@/%@", documentsDirectoryPath, path];
            [temp addObject: model];
        }
        completion(temp, Nil);
    } @catch (NSException *exception) {
        NSError *err = [NSError setError:FailedGetDocuments];
        completion(Nil, err);
    }
}

- (void)saveDocument:(NSURL *)url success:(void (^)(NSError * _Nullable))completion{
    NSString *title = [url URLByDeletingPathExtension].lastPathComponent;
    NSString *ext = url.pathExtension;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    
    NSString *destUrl = [[documentsDirectoryPath stringByAppendingPathComponent:title] stringByAppendingPathExtension:ext];
    
    @try {
        NSError *err;
        [fileManager copyItemAtPath:url.path toPath:destUrl error:&err];
        if(err == nil){
            completion(Nil);
        }else{
            NSError *err = [NSError setError:FailedSaveDocument];
            completion(err);
        }
    } @catch (NSException *exception) {
        NSError *err = [NSError setError:FailedSaveDocument];
        completion(err);
    }
}

- (void)deleteDocument:(NSURL *)url success:(void (^)(NSError * _Nullable))completion{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if([fileManager fileExistsAtPath:url.path] == TRUE){
        @try {
            NSError *err;
            [fileManager removeItemAtPath:url.path error:&err];
            if(err == nil){
                completion(Nil);
            }else{
                NSError *err = [NSError setError:FailedDeleteDocument];
                completion(err);
            }
        } @catch (NSException *exception) {
            NSError *err = [NSError setError:FailedDeleteDocument];
            completion(err);
        }
    }
}

@end
