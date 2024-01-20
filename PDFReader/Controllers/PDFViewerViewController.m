//
//  PDFViewerViewController.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFViewerViewController.h"

@interface PDFViewerViewController ()

@property(strong, nonatomic) PDFView *pdfView;
@property (strong, nonatomic) PDFModel *model;
@property (strong, nullable) PDFPageIndicatorUIView *indicatorView;

@end

@implementation PDFViewerViewController

NSUInteger currentPageNumber = 0;
NSUInteger totalPages = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePageChange:) name:PDFViewPageChangedNotification object:nil];
    
//    NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
}

- (instancetype)initWithDocument:(PDFModel *)model{
    if(self == [super initWithNibName:nil bundle:nil]){
        _model = model;
        [self configurePDF];
        [self configurePageIndicator];
    }
    return self;
}

- (void)configurePDF{
    _pdfView = [[PDFView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_pdfView];
    _pdfView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [_pdfView usePageViewController:TRUE withViewOptions:nil];
    _pdfView.displayDirection = kPDFDisplayDirectionHorizontal;
    _pdfView.autoScales = TRUE;
    _pdfView.displayMode = kPDFDisplaySinglePage;
    
    NSURL *url = [NSURL fileURLWithPath:_model.path];
    if(url == nil){
        return;
    }
    
    PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
    if(doc != nil){
        _pdfView.document = doc;
        totalPages = _pdfView.document.pageCount;
    }
}

- (void)configurePageIndicator{
    _indicatorView = [[PDFPageIndicatorUIView alloc] init];
    _indicatorView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview: _indicatorView];
    [_indicatorView configure:totalPages currentPage:currentPageNumber];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [NSLayoutConstraint activateConstraints:@[
    
       [_indicatorView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
       [_indicatorView.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        
    ]];
    
}

- (void)handlePageChange:(id *)sender{
    
    PDFPage *currentPage = _pdfView.currentPage;
    if(currentPage == nil){
        return;
    }
    NSUInteger pageIndex = [_pdfView.document indexForPage:currentPage];
    currentPageNumber = pageIndex;
    [_indicatorView configure:totalPages currentPage:currentPageNumber];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PDFViewPageChangedNotification object:nil];
}


@end
