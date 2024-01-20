//
//  PDFPageIndicatorUIView.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFPageIndicatorUIView.h"

@interface PDFPageIndicatorUIView ()

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *pageNumbers;

@end

@implementation PDFPageIndicatorUIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView{
    
    self.backgroundColor = UIColor.lightGrayColor;
    self.layer.cornerRadius = 5;
    
    _icon = [[UIImageView alloc] init];
    [self addSubview:_icon];
    _icon.translatesAutoresizingMaskIntoConstraints = FALSE;
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *img = [UIImage systemImageNamed:@"book.pages"];
    [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _icon.tintColor = UIColor.blackColor;
    [_icon setImage:img];
    
    _pageNumbers = [[UILabel alloc] init];
    [self addSubview:_pageNumbers];
    _pageNumbers.translatesAutoresizingMaskIntoConstraints = FALSE;
    _pageNumbers.numberOfLines = 1;
    [_pageNumbers setTextColor:UIColor.blackColor];
    _pageNumbers.font = [UIFont boldSystemFontOfSize:12];
    _pageNumbers.text = @"0 / 0";
    
    
}

- (void)configure:(NSInteger)totalPages currentPage:(NSInteger)currentPage{
    NSString *total = [@(totalPages) stringValue];
    NSString *current = [@(currentPage + 1) stringValue];
    _pageNumbers.text = [NSString stringWithFormat:@"%@ / %@", current, total];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [NSLayoutConstraint activateConstraints:@[
        
       [_icon.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
       [_icon.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
       [_icon.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
       [_icon.trailingAnchor constraintEqualToAnchor:_pageNumbers.leadingAnchor constant:-5],
       
       [_pageNumbers.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
       [_pageNumbers.leadingAnchor constraintEqualToAnchor:_icon.trailingAnchor constant:5],
       [_pageNumbers.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
       [_pageNumbers.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],

    ]];
}

@end
