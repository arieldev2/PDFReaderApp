//
//  PDFDocumentCollectionViewCell.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFDocumentCollectionViewCell.h"

@interface PDFDocumentCollectionViewCell ()

@property (strong, nonatomic) PDFView *pdfView;
@property (strong, nonatomic) PDFThumbnailView *thumbnailView;
@property (strong, nonatomic) UILabel *documentTitle;
@property (strong, nonatomic) NSURL *docUrl;

@end

@implementation PDFDocumentCollectionViewCell

+ (NSString *)identifier{
    return NSStringFromClass([PDFDocumentCollectionViewCell class]);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
        [self configureContextMenu];
    }
    return self;
}

- (void)configureView{
    _pdfView = [[PDFView alloc] init];
    _pdfView.userInteractionEnabled = FALSE;
    _pdfView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.contentView addSubview:_pdfView];
    
    _thumbnailView = [[PDFThumbnailView alloc] init];
    _thumbnailView.userInteractionEnabled = FALSE;
    _thumbnailView.thumbnailSize = CGSizeMake(100, 100);
    _thumbnailView.layoutMode = PDFThumbnailLayoutModeVertical;
    _thumbnailView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.contentView addSubview:_thumbnailView];
    
    _documentTitle = [[UILabel alloc] init];
    _documentTitle.numberOfLines = 1;
    _documentTitle.font = [UIFont systemFontOfSize:10];
    _documentTitle.textAlignment = NSTextAlignmentCenter;
    _documentTitle.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.thumbnailView addSubview:_documentTitle];
}

- (void)configure:(PDFModel *)model{
    
    __typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURL *url = [NSURL fileURLWithPath:model.path];
        if(url == nil){
            return;
        }
        weakSelf.docUrl = url;
        PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
        if(doc == nil){
            return;
        }
        weakSelf.pdfView.document = doc;
        weakSelf.thumbnailView.PDFView = weakSelf.pdfView;
        weakSelf.documentTitle.text = model.title;
        
    });
    

}

- (void)configureContextMenu{
    UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [self addInteraction:interaction];
}

- (UIMenu *)createContextMenu{
    UIAction * shareAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        [self.delegate deletePdf:self.docUrl];
    }];
    return [UIMenu menuWithTitle:@"" children:@[shareAction]];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [NSLayoutConstraint activateConstraints:@[
        
        [_pdfView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [_pdfView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [_pdfView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [_pdfView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        
        [_thumbnailView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [_thumbnailView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [_thumbnailView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [_thumbnailView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        
        [_documentTitle.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [_documentTitle.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor],
        [_documentTitle.bottomAnchor constraintEqualToAnchor:_thumbnailView.bottomAnchor constant:-1],

    ]];
}

- (UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location{
    return [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        return [self createContextMenu];
    }];
}

@end
