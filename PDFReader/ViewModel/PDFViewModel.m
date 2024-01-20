//
//  PDFViewModel.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFViewModel.h"

@implementation PDFViewModel

- (void)getDocuments{
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
        [_delegate getDocuments:temp];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (void)saveDocument:(NSURL *)url{
    
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
            [self getDocuments];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (void)deleteDocument:(NSURL *)url{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if([fileManager fileExistsAtPath:url.path] == TRUE){
        @try {
            NSError *err;
            [fileManager removeItemAtPath:url.path error:&err];
            if(err == nil){
                [self getDocuments];
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
    }
}

@end
