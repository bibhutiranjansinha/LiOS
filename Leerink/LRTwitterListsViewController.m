//
//  LRTwitterListsViewController.m
//  Leerink
//
//  Created by Ashish on 26/09/2014.
//  Copyright (c) 2014 leerink. All rights reserved.
//

#import "LRTwitterListsViewController.h"
#import "STTwitter.h"
#import "LRTwitterListTableViewCell.h"
#import "LRTwitterListTweetsViewController.h"

@interface LRTwitterListsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *twitterListsTableView;

@end

@implementation LRTwitterListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.twitterListsTableView.delegate = self;
    self.twitterListsTableView.dataSource = self;
    self.twitterListsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = @"Lists";
    
    //self.twitterListsArray = (NSMutableArray *)[[LRCoreDataHelper sharedStorageManager] fetchObjectsForEntityName:@"LRTwitterList" withPredicate:nil, nil];
    
  //  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"listCreatedDate"
      //                                                            ascending:NO];
   // NSArray *sortDescriptors = @[sortDescriptor];
    
    //self.twitterListsArray = [self.twitterListsArray sortedArrayUsingDescriptors:sortDescriptors];
    
    
    [self.twitterListsTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f],
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor]
                                                                      }];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:9.0/255.0 green:60.0/255.0 blue:113/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;

}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.twitterListsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = NSStringFromClass([LRTwitterListTableViewCell class]);
    
    LRTwitterListTableViewCell *cell = [self.twitterListsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (LRTwitterListTableViewCell *)[bundle objectAtIndex: 0];
    }
    
    NSDictionary *twitterListDictionary = [self.twitterListsArray objectAtIndex:indexPath.row];
    
    NSString *profileImageUrlString = [twitterListDictionary objectForKey:@"profile_image_url"];
    UIImage *memberImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrlString]]];
    if(memberImage!=nil)
        [cell fillDataForDocumentCellwithTwitterListMemberName:[twitterListDictionary objectForKey:@"name"] andMemberImage:memberImage];
    else
    {
        memberImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[twitterListDictionary objectForKey:@"profile_image_url"] stringByReplacingOccurrencesOfString:@"http" withString:@"https"]]  ]];
        if(memberImage!=nil)
            [cell fillDataForDocumentCellwithTwitterListMemberName:[twitterListDictionary objectForKey:@"name"] andMemberImage:memberImage];
        else
            [cell fillDataForDocumentCellwithTwitterListMemberName:[twitterListDictionary objectForKey:@"name"] andMemberImage:[UIImage imageNamed:@"Twitter-32"]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRTwitterListTweetsViewController *aTweetsListVoiewController = [[LRAppDelegate myStoryBoard] instantiateViewControllerWithIdentifier:@"LRTwitterListTweetsViewController"];
    NSDictionary *twitterListDictionary = [NSDictionary new];
    twitterListDictionary = [self.twitterListsArray objectAtIndex:indexPath.row];
    NSDictionary *aUserDetailsDictionary = [twitterListDictionary objectForKey:@"user"];
    
    aTweetsListVoiewController.aTwitterListScreenName = [aUserDetailsDictionary objectForKey:@"name"];
    aTweetsListVoiewController.aTwitterListOwnerId = [aUserDetailsDictionary objectForKey:@"id_str"];
    aTweetsListVoiewController.aTwitterListSlug = [twitterListDictionary objectForKey:@"slug"];

    aTweetsListVoiewController.isTwitterListCountMoreThanOne = TRUE;
    [self.navigationController pushViewController:aTweetsListVoiewController animated:TRUE];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
