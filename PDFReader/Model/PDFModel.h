//
//  PDFModel.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFModel : NSObject

@property (strong , nonatomic) NSUUID *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *path;

- (instancetype)initWithID:(NSUUID *)id title:(NSString *)title path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
