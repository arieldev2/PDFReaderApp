//
//  PDFReaderTests.m
//  PDFReaderTests
//
//  Created by Ariel Ortiz on 1/21/24.
//

#import <XCTest/XCTest.h>
#import "PDFViewModel.h"
#import "PDFServiceMock.h"
#import "PDFViewModelProtocol.h"

@interface PDFReaderTests : XCTestCase <PDFViewModelDelegate>

@property (strong, nonatomic) PDFViewModel *viewModel;
@property (strong, nonatomic) NSArray<PDFModel *> *documents;
@property (nonatomic) Boolean success;


@end

@implementation PDFReaderTests

- (void)setUp {
    _viewModel = [[PDFViewModel alloc] initWithService:[PDFServiceMock sharedService]];
    _documents = @[];
    _viewModel.delegate = self;
    _success = FALSE;
}

- (void)tearDown {
    
}

- (void)testGetDocumentsNotNil {
    [_viewModel getDocuments];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertNotNil(self.documents);
    });
}

- (void)testGetDocumentsEqualTo4{
    [_viewModel getDocuments];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssertEqual(self.documents.count, 4);
    });
}

- (void)testSaveDocumentTrue{
    NSURL *url = [NSURL URLWithString:@"randomUrl"];
    [_viewModel saveDocument:url];
    XCTAssertTrue(self.success);
}

- (void)testDeleteDocumentTrue{
    NSURL *url = [NSURL URLWithString:@"randomUrl"];
    [_viewModel deleteDocument:url];
    XCTAssertTrue(self.success);
}



- (void)getDocuments:(NSArray<PDFModel *> *)documents{
    self.documents = documents;
}

- (void)saveDocument:(NSError *)error{
    if(error == Nil){
        _success = TRUE;
    }
}

- (void)deleteDocument:(NSError *)error{
    if(error == Nil){
        _success = TRUE;
    }
}


@end
