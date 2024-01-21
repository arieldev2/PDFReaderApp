//
//  ViewController.m
//  PDFReader
//
//  Created by Ariel Ortiz on 1/19/24.
//

#import "PDFHomeViewController.h"


@interface PDFHomeViewController ()

@property (strong, nonatomic) PDFViewModel *viewModel;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewDiffableDataSource<NSString *, PDFModel *> *dataSource;
@property (strong, nonatomic) PDFEmptyUIView *emptyView;
@property (strong, nonatomic) NSArray<PDFModel *> *documents;
@property (strong, nonatomic) NSArray<PDFModel *> *filterdDocuments;

@end

@implementation PDFHomeViewController

bool isSearching = FALSE;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PDF Reader";
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.down"] style:UIBarButtonItemStyleDone target:self action:@selector(importDocument:)];
    [self configureViewModel];
    [self configureSearchController];
    [self configureEmptyView];
    [self configureCollection];
    [self configureDataSource];
}

- (void)configureViewModel{
    _documents = @[];
    _filterdDocuments = @[];
    _viewModel = [[PDFViewModel alloc] init];
    _viewModel.delegate = self;
    [_viewModel getDocuments];
}

- (void)importDocument:(id)sender {
    NSArray<UTType *> *allowedUTIs = @[UTTypePDF];
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:allowedUTIs asCopy:FALSE];
    documentPicker.delegate = self;
    documentPicker.allowsMultipleSelection = FALSE;
    documentPicker.modalPresentationStyle = UIModalPresentationAutomatic;
    [self presentViewController:documentPicker animated:TRUE completion:Nil];
}

- (void)configureSearchController{
    UISearchController *searchController = [[UISearchController alloc] init];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    searchController.searchBar.placeholder = @"Search PDF";
    searchController.obscuresBackgroundDuringPresentation = false;
    self.navigationItem.searchController = searchController;
}

- (void)configureEmptyView{
    _emptyView = [[PDFEmptyUIView alloc] init];
    [self.view addSubview:_emptyView];
    _emptyView.frame = self.view.bounds;
    [_emptyView setHidden:TRUE];
}

- (void)configureCollection{
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self createFlowLayout]];
    [_collectionView registerClass:PDFDocumentCollectionViewCell.class forCellWithReuseIdentifier:PDFDocumentCollectionViewCell.identifier];
    _collectionView.delegate = self;
    _collectionView.dataSource = _dataSource;
    [self.view addSubview:_collectionView];
}

- (UICollectionViewFlowLayout *)createFlowLayout{
    CGFloat width = self.view.bounds.size.width;
    CGFloat padding = 12;
    CGFloat minimumItemSpacing = 10;
    CGFloat availableWidth = width - (padding*2) - (minimumItemSpacing*2);
    CGFloat itemWidth = availableWidth / 3;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.itemSize = CGSizeMake(itemWidth, itemWidth + 50);
    return layout;
}

- (void)configureDataSource{
    _dataSource = [[UICollectionViewDiffableDataSource<NSString *, PDFModel *> alloc] initWithCollectionView:_collectionView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        
        PDFDocumentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PDFDocumentCollectionViewCell.identifier forIndexPath:indexPath];
        if(cell == Nil){
            return [[UICollectionViewCell alloc] init];
        }
        cell.delegate = self;
        [cell configure:itemIdentifier];
        return cell;
        
    }];
}

- (void)updateSnapshot:(NSArray<PDFModel *> *)documents{
    NSDiffableDataSourceSnapshot *snapshot = [[NSDiffableDataSourceSnapshot<NSString *, PDFModel *> alloc] init];
    [snapshot appendSectionsWithIdentifiers:@[@"all"]];
    [snapshot appendItemsWithIdentifiers:documents intoSectionWithIdentifier:@"all"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dataSource applySnapshot:snapshot animatingDifferences:TRUE];
    });
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:TRUE];
    
    NSArray<PDFModel *> *selectedArray = isSearching ? _filterdDocuments : _documents;
    PDFModel *model = selectedArray[indexPath.row];
    PDFViewerViewController *viewer = [[PDFViewerViewController alloc] initWithDocument:model];
    [self.navigationController pushViewController:viewer animated:TRUE];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString * filter = searchController.searchBar.text;
    if(filter.length == 0){
        isSearching = FALSE;
        [self updateSnapshot: self.documents];
        return;
    }
    isSearching = TRUE;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@",filter];
    _filterdDocuments = [_documents filteredArrayUsingPredicate:predicate];
    [self updateSnapshot:_filterdDocuments];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isSearching = FALSE;
    [self updateSnapshot:_documents];
}

- (void)getDocuments:(NSArray<PDFModel *> *)documents{
    _documents = documents;
    [self checkEmptyPDF];
    [self updateSnapshot: _documents];
}

- (void)checkEmptyPDF{
    if(_documents.count > 0){
        if(_collectionView.isHidden){
            [_collectionView setHidden:FALSE];
            [_emptyView setHidden:TRUE];
        }
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView setHidden:TRUE];
            [self.emptyView setHidden:FALSE];
        });
    }
}


- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    
    NSURL *url = urls.firstObject;
    if(url == Nil){
        return;
    }
    
    BOOL isAccessGranted = [url startAccessingSecurityScopedResource];
    NSError *err;
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    [fileCoordinator coordinateReadingItemAtURL:url options:NSFileCoordinatorReadingWithoutChanges error:&err byAccessor:^(NSURL *newURL) {
                
        if(isAccessGranted){
            [_viewModel saveDocument:newURL];
        }
        [newURL stopAccessingSecurityScopedResource];
        }];
    
}

- (void)deletePdf:(NSURL *)url{
    [_viewModel deleteDocument:url];
}

@end


