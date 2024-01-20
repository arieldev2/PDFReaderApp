//
//  PDFEmptyUIView.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/20/24.
//

#import "PDFEmptyUIView.h"

@interface PDFEmptyUIView ()

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation PDFEmptyUIView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure{
    _messageLabel = [[UILabel alloc] init];
    [self addSubview:_messageLabel];
    _messageLabel.translatesAutoresizingMaskIntoConstraints = FALSE;
    _messageLabel.text = @"No PDF added yet";
    _messageLabel.font = [UIFont boldSystemFontOfSize:30];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [NSLayoutConstraint activateConstraints:@[
        [_messageLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [_messageLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
    ]];
}

@end
