//
//  ViewController.h
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import <UIKit/UIKit.h>
#import "PDFDocumentCollectionViewCell.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import <CoreServices/CoreServices.h>
#import "PDFViewModel.h"
#import "PDFViewerViewController.h"
#import "PDFDocumentCollectionViewCell.h"
@class PDFModel;


@interface PDFHomeViewController : UIViewController <UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UIDocumentPickerDelegate, PDFViewModelDelegate, PDFDocumentCollectionViewCellDelegate>


@end

