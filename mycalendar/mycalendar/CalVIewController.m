//
//  CalVIewController.m
//  MyCalendar
//
//  Created by hero on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalVIewController.h"

@implementation CalVIewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *now=[calendar components:unitFlags fromDate:[NSDate date]];
    
    scheduleDal *sd=[[scheduleDal alloc]init];
    
    calView.passArr=[sd selectSql:[NSString stringWithFormat:@"%04d年%02d月%02d日",[now year],[now month],[now day]]];
    [calendar release];
    [sd release];
    [comment reloadData];
}

-(void)calHeadClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://blog.sina.com.cn/dssb1234"]]; 
}

#pragma mark-
#pragma mark 界面初始化
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{       
    self.title=@"返回";
    self.view.backgroundColor=[UIColor whiteColor];
    
    tempview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:tempview];
    
    UIImageView *calHeadImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [calHeadImg setImage:[UIImage imageNamed:@"gg.png"]];
    [tempview addSubview:calHeadImg];
    [calHeadImg release];
        
    UIButton *calHead=[UIButton buttonWithType:UIButtonTypeCustom];
    calHead.frame=CGRectMake(0, 0, 320, 140);
    [calHead setBackgroundImage:[UIImage imageNamed:@"上方广告.png"] forState:UIControlStateNormal];
    [calHead addTarget:self action:@selector(calHeadClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempview addSubview:calHead];
    
    UIImageView *calModel=[[UIImageView alloc] initWithFrame:CGRectMake(0, 140, 320, 60)];
    [calModel setImage:[UIImage imageNamed:@"中间.png"]];
    [tempview addSubview:calModel];
    [calModel release];
    
    NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *now=[calendar components:unitFlags fromDate:[NSDate date]];

    scheduleDal *sd=[[scheduleDal alloc]init];
    
    calView=[[CalView alloc] init];
    calView.passArr=[sd selectSql:[NSString stringWithFormat:@"%04d年%02d月%02d日",[now year],[now month],[now day]]];
    [calendar release];
    [sd release];

    calView.year=[now year];
    calView.month=[now month];
    calView.day=[now day];
    calView.view.frame=CGRectMake(0, 200, 320, 160);
    calView.delegate=self;
    [tempview addSubview:calView.view];
    
    
    UIImageView *calcomment=[[UIImageView alloc] initWithFrame:CGRectMake(0, 360, 320, 100)];
    [calcomment setImage:[UIImage imageNamed:@"日程1.png"]];
    [tempview addSubview:calcomment];
    [calcomment release];
    
    comment=[[UITableView alloc] initWithFrame:CGRectMake(13, 365, 296, 50)];
    comment.backgroundColor=[UIColor clearColor];
    comment.delegate=self;
    comment.dataSource=self;
    [tempview addSubview:comment];
    calView.passTable=comment;
    
    UIButton *juBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [juBtn setFrame:CGRectMake(225, 426, 30, 30)];
    [juBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
    [juBtn addTarget:self action:@selector(juBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempview addSubview:juBtn];
    
    UIButton *calBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [calBtn setFrame:CGRectMake(255, 426, 30, 30)];
    [calBtn setBackgroundImage:[UIImage imageNamed:@"搜索按钮.png"] forState:UIControlStateNormal];
    [calBtn addTarget:self action:@selector(calBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempview addSubview:calBtn];
    
    UIButton *somethingsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [somethingsBtn setFrame:CGRectMake(285, 426, 30, 30)];
    [somethingsBtn setBackgroundImage:[UIImage imageNamed:@"日程按钮.png"] forState:UIControlStateNormal];
    [somethingsBtn addTarget:self action:@selector(somethingsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempview addSubview:somethingsBtn];
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [tempview addGestureRecognizer:recognizer];
    [recognizer release];
    
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [tempview addGestureRecognizer:recognizer];
    [recognizer release];
    
    lblyear=[[UILabel alloc] initWithFrame:CGRectMake(55, 430, 150, 25)];
    lblyear.text=[NSString stringWithFormat:@"%d %@",calView.year,calView.Nyear];
    lblyear.backgroundColor=[UIColor clearColor];
    lblyear.font=[UIFont fontWithName:@"" size:18];
    [self.view addSubview:lblyear];

    UIButton *btninfo=[UIButton buttonWithType:UIButtonTypeCustom];
    [btninfo setFrame:CGRectMake(0, 426, 30, 30)];
    [btninfo setBackgroundImage:[UIImage imageNamed:@"关于按钮.png"] forState:UIControlStateNormal];
    [btninfo addTarget:self action:@selector(btninfoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btninfo];
    
    [super viewDidLoad];
}

-(void)juBtnClick:(id)sender{
    NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *now=[calendar components:unitFlags fromDate:[NSDate date]];
    
    calView.year=[now year];
    calView.month=[now month];
    calView.day=[now day];
    [calView.view removeFromSuperview];
    [calView viewDidLoad];
    [tempview addSubview:calView.view];
    [calTempView removeFromSuperview];
}

-(void)btninfoClick:(id)sender{
    [aboutView removeFromSuperview];
    aboutView=[[UIView alloc] initWithFrame:CGRectMake(15, 15, 290, 430)];
    aboutView.backgroundColor=[UIColor blackColor];
    aboutView.alpha=0.8;
    
    UIScrollView *src=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 290, 430)];
    src.pagingEnabled = YES;
	src.directionalLockEnabled = YES;
    [aboutView addSubview:src];
    
    UIImageView *aboutImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 775)];
    [aboutImg setImage:[UIImage imageNamed:@"关于.png"]];
    [src addSubview:aboutImg];
    src.contentSize = aboutImg.frame.size;
    [aboutImg release];
    [self.view addSubview:aboutView];
    [src release];
    
    UIButton *closeAboutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [closeAboutBtn setImage:[UIImage imageNamed:@"cha.png"] forState:UIControlStateNormal];
    closeAboutBtn.frame=CGRectMake(260, 0, 30, 30);
    [closeAboutBtn addTarget:self action:@selector(closeAboutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aboutView addSubview:closeAboutBtn];
}

-(void)closeAboutBtnClick:(id)sender{
    [aboutView removeFromSuperview];
}

-(void)ShowNyearMonth{
    lblyear.text=[NSString stringWithFormat:@"%d %@",calView.year,calView.Nyear];
}

-(void)calBtnClick:(id)sender{
    
    calTempView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [calTempView setBackgroundColor:[UIColor blackColor]];
    [calTempView setAlpha:0.8];
    
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];
    
    picker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 80, 320, 200)];
    [picker setDatePickerMode:UIDatePickerModeDate];
    picker.minimumDate=[dateFormater dateFromString:@"1900-2-1 00:00:00 +0000"];
    picker.maximumDate=[dateFormater dateFromString:@"2049-12-31 00:00:00 +0000"];
    
    UIButton *btnJump=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnJump setTitle:@"跳转" forState:UIControlStateNormal];
    [btnJump setFrame:CGRectMake(80, 360, 60, 40)];
    [btnJump addTarget:self action:@selector(btnJumpClick:) forControlEvents:UIControlEventTouchUpInside];
    [calTempView addSubview:btnJump];
    
    UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnClose setTitle:@"取消" forState:UIControlStateNormal];
    [btnClose setFrame:CGRectMake(180, 360, 60, 40)];
    [btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    [calTempView addSubview:btnClose];
    
    [calTempView addSubview:picker];
    [self.view addSubview:calTempView];
        
}

-(void)btnJumpClick:(id)sender{
    NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *now=[calendar components:unitFlags fromDate:[picker date]];
    
    calView.year=[now year];
    calView.month=[now month];
    calView.day=[now day];
    [calView.view removeFromSuperview];
    [calView viewDidLoad];
    [tempview addSubview:calView.view];
    [calTempView removeFromSuperview];
}

-(void)btnCloseClick:(id)sender{
    [calTempView removeFromSuperview];
}

-(void)somethingsBtnClick:(id)sender{
    wdc=[[WriteDataController alloc] init];
    wdc.isNoInsert=true;
    [self.navigationController pushViewController:wdc animated:YES];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        if (calView.year<=1900&&calView.month<=2) {}
        else{
             [UIView beginAnimations:@"animationID" context:nil];
             [UIView setAnimationDuration:0.8f];
             [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
             [UIView setAnimationRepeatAutoreverses:NO];
             [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:calView.view cache:YES];
             calView.day=0;
             calView.month-=1;
            if (calView.month==0) {
                calView.month=12;
                calView.year-=1;
            }
            [calView.view removeFromSuperview];
            [calView viewDidLoad];
            [tempview addSubview:calView.view];
            [UIView commitAnimations];
        }
    }
    if (recognizer.direction==UISwipeGestureRecognizerDirectionUp) { 
        
        if (calView.month>=12&&calView.year>=2049) {}
        else{
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:0.8f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationRepeatAutoreverses:NO];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:calView.view cache:YES];
            calView.day=0;
            calView.month+=1;
            if (calView.month==13) {
                calView.month=1;
                calView.year+=1;
            }
            [calView.view removeFromSuperview];
            [calView viewDidLoad];
            [tempview addSubview:calView.view];
            [UIView commitAnimations];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 25;
}
#pragma mark-
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return calView.passArr!=nil?[calView.passArr count]:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    detailViewController = [[WriteDataController alloc] init];
    detailViewController.passArr=[calView.passArr objectAtIndex:indexPath.row];
    detailViewController.isNoInsert=false;
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{ 
    return @"删除"; 
} 

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         scheduleDal *sd=[[scheduleDal alloc] init];
         
         [sd deleteScheduleList:[[calView.passArr objectAtIndex:indexPath.row] objectAtIndex:3]];
         
         [calView.passArr removeObjectAtIndex:indexPath.row];
         
         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
         [sd release];
         
     }   
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }   
 }
 

#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text=[[calView.passArr objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.textLabel.font=[UIFont systemFontOfSize:18];
    // Configure the cell...
    
    return cell;
}

#pragma mark -

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [detailViewController release];
    [lblyear release];
    [wdc release];
    [calBackground release];
    [calView release];
    [comment release];
    [picker release];
    [calTempView release];
    [tempview release];
    [aboutView release];
    [super dealloc];
}
@end
