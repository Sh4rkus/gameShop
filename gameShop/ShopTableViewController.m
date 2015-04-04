//
//  ShopTableViewController.m
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopTableViewController.h"
#import "ShopDataSource.h"
#import "Skin.h"

@interface ShopTableViewController ()

@property(nonatomic) ShopDataSource *dataSource;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;

@end

enum { ITEM_VIEW_HEIGHT = 180, GAP_BTWN_VIEWS = 5, IMAGE_HEIGHT = 120, IMAGE_WIDTH = 120 };

static NSString *CellIdentifier = @"Cell";

@implementation ShopTableViewController

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self) {
        //Custom Initialization
    }
    self.dataSource = [[ShopDataSource alloc] initWithSkins];
    
    self.title = @"Ye Olde Shoppe";
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    //self.dataSource.delegate = self
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataSourceReadyForUse:(ShopDataSource *) dataSource
{
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.{
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped: YES];
    
    return 1;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ITEM_VIEW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"Number of rows in the table: %@", @([self.dataSource numberOfSkins]));
    return [self.dataSource numberOfSkins];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell = [self skinViewForIndex:[indexPath row] withTableViewCell:cell];
    
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

/*- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Skin *skin = [self.dataSource skinAtIndex:[indexPath row]];
    MoviesDetailedViewController *mController = [[MoviesDetailedViewController alloc] initWithMoive: movie];
    [self.navigationController pushViewController:mController animated:YES];
}*/

-(UITableViewCell *) skinViewForIndex: (NSInteger) rowIndex withTableViewCell: (UITableViewCell *) cell
{
    enum {IMAGE_VIEW_TAG = 20, MAIN_VIEW_TAG = 50, LABEL_TAG = 30};
    
    Skin *skin = [self.dataSource skinAtIndex: rowIndex];
    

    UIView *view = [cell viewWithTag: MAIN_VIEW_TAG];
    
    if( view ) {
        UIImageView *iv = (UIImageView *)[view viewWithTag: IMAGE_VIEW_TAG];
        NSArray *views = [iv subviews];
        for( UIView *v in views )
            [v removeFromSuperview];
        //iv.image = [skin imageForListEntry];
        UILabel *aLabel = (UILabel *) [view viewWithTag: LABEL_TAG];
        aLabel.attributedText = [skin skinForListEntry];
        return cell;
    }
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    CGRect viewFrame = CGRectMake(0, 0, bounds.size.width, ITEM_VIEW_HEIGHT);
    
    UIView *thisView = [[UIView alloc] initWithFrame: viewFrame];
    
   // UIImage *img = [skin imageForListEntry];
    CGRect imgFrame = CGRectMake(10, (viewFrame.size.height - IMAGE_HEIGHT) / 2, IMAGE_WIDTH, IMAGE_HEIGHT );
   // UIImageView *iView = [[UIImageView alloc] initWithImage: img];
   // iView.tag = IMAGE_VIEW_TAG;
   // iView.frame = imgFrame;
   // [thisView addSubview: iView];
    
    UILabel *skinInfoLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(IMAGE_WIDTH + 2 * 10, 5,
                                                        viewFrame.size.width - IMAGE_WIDTH - 10,
                                                        viewFrame.size.height -5)];
    
    skinInfoLabel.tag = LABEL_TAG;
    NSAttributedString *desc = [skin skinForListEntry];
    
    NSLog(@"Skin Description %@", desc);
    
    skinInfoLabel.attributedText = desc;
    skinInfoLabel.numberOfLines = 0;
    [thisView addSubview: skinInfoLabel];
    thisView.tag = MAIN_VIEW_TAG;
    [[cell contentView] addSubview:thisView];
    
    return cell;
}

@end