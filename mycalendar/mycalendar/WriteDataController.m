//
//  WriteDataController.m
//  MyCalendar
//
//  Created by hero on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WriteDataController.h"

@implementation WriteDataController

@synthesize deletekey;
@synthesize passArr;
@synthesize isNoInsert;

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
    [self.navigationController setNavigationBarHidden:NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
     
    UIImageView *calHeadImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [calHeadImg setImage:[UIImage imageNamed:@"背景.png"]];
    [self.view addSubview:calHeadImg];
    [calHeadImg release];
    
    NSUInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
	NSCalendar *calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	now=[calendar components:unitFlags fromDate:[NSDate date]];
    self.title=[NSString stringWithFormat:@"%04d年%02d月%02d日",[now year],[now month],[now day]];
    
    UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithTitle:@"日期" style:UIBarButtonItemStyleBordered target:self action:@selector(barClick:)];
    self.navigationItem.rightBarButtonItem=bar;
    [bar release];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setFrame:CGRectMake(0, 0, 320, 460)];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(30, 30, 40, 20)];
    [lblTitle setText:@"标题:"];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lblTitle];
    [lblTitle release];
    
    txtTitle=[[UITextField alloc] initWithFrame:CGRectMake(80, 27, 200, 30)];
    [txtTitle setBorderStyle:UITextBorderStyleRoundedRect];
    [txtTitle addTarget:self action:@selector(textFiledEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:txtTitle];
    
    UILabel *lblContext=[[UILabel alloc] initWithFrame:CGRectMake(30, 80, 40, 20)];
    lblContext.text=@"详情";
    [lblContext setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lblContext];
    [lblContext release];
    
    txtContext=[[UITextView alloc] initWithFrame:CGRectMake(80, 77, 200, 220)];
    txtContext.layer.borderColor = [UIColor grayColor].CGColor;
    txtContext.backgroundColor=[UIColor clearColor];
    txtContext.layer.borderWidth =1.0;
    txtContext.layer.cornerRadius =5.0;
    txtContext.font=[UIFont systemFontOfSize:20];
    txtContext.delegate=self;
    [self.view addSubview:txtContext];
    [txtContext release];
    
    UIButton *finishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setFrame:CGRectMake(20, 320, 280, 40)];
    [finishBtn setBackgroundImage:[UIImage imageNamed:@"绿完成.png"] forState:UIControlStateNormal];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
    
    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setFrame:CGRectMake(20, 370, 280, 40)];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"红按钮.png"] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    if (passArr!=nil) {
        txtTitle.text=[passArr objectAtIndex:0];
        txtContext.text=[passArr objectAtIndex:1];
        self.title=[passArr objectAtIndex:2];
        deletekey=[passArr objectAtIndex:3];
    }
    
    [super viewDidLoad];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.view.frame=CGRectMake(0, -75, 320, 460);
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];   
    [topView setBarStyle:UIBarStyleBlackOpaque];
    topView.alpha=0.8;
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];   
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backBtnClick:)];   
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];   
    [doneButton release];   
    [btnSpace release];   
    [topView setItems:buttonsArray];   
    [textView setInputAccessoryView:topView];
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    self.view.frame=CGRectMake(0, 0, 320, 460);
}

-(void)barClick:(id)sender{
    [txtContext resignFirstResponder];
    [txtTitle resignFirstResponder];
    
    [calTempView removeFromSuperview];
    
    calTempView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [calTempView setBackgroundColor:[UIColor blackColor]];
    [calTempView setAlpha:0.8];
    
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd hh:mm:ss Z"];

    picker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 80, 320, 200)];
    picker.minimumDate=[dateFormater dateFromString:@"1900-2-1 00:00:00 +0000"];
    picker.maximumDate=[dateFormater dateFromString:@"2049-12-31 00:00:00 +0000"];

    [picker setDatePickerMode:UIDatePickerModeDate];
    UIButton *btnJump=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnJump setTitle:@"选择" forState:UIControlStateNormal];
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
	now=[calendar components:unitFlags fromDate:[picker date]];
    self.title=[NSString stringWithFormat:@"%04d年%02d月%02d日",[now year],[now month],[now day]];
    [calTempView removeFromSuperview];
}

-(void)btnCloseClick:(id)sender{
    [calTempView removeFromSuperview];
}

-(void)initAlertView:(id)sender tag:(int)tag{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"是否%@日程？",((UIButton*)sender).titleLabel.text] delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    alert.tag=tag;
    alert.delegate=self;
    [alert show];
    [alert release];
    
}

-(void)messageBox:(NSString*)msg{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate=self;
    [alert show];
    [alert release];
}

-(void)deleteBtnClick:(id)sender{
    if (deletekey!=nil) {
        [self initAlertView:sender tag:1];
    }
    else{
        [self messageBox:@"添加状态。。。无删除目标！"];
    }
}

-(void)finishBtnClick:(id)sender{
    if (txtTitle.text==nil||[txtTitle.text isEqualToString:@""]) {
        [self messageBox:@"请填写标题！"];
    }
    else if(txtContext.text==nil||[txtContext.text isEqualToString:@""]){
        [self messageBox:@"请填写详情！"];
    }
    else{
        [self initAlertView:sender tag:2];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    scheduleDal *sd=[[scheduleDal alloc] init];
    if(buttonIndex==1){      
        if (alertView.tag==1) {
            [sd deleteScheduleList:deletekey];
            [self messageBox:@"删除成功！"];
        }
        else if(alertView.tag==2){
            if (isNoInsert) {
                [sd insertScheduleList:txtTitle.text context:txtContext.text dateKey:self.title];
                [self messageBox:@"添加成功！"];
            }
            else{
                [sd updateScheduleList:txtTitle.text context:txtContext.text dateKey:self.title scheduleKey:deletekey];
                [self messageBox:@"修改成功！"];
            }
        }
    }
    [sd release];
}

-(void)backBtnClick:(id)sender{
    [txtContext resignFirstResponder];
    [txtTitle resignFirstResponder];
}

-(void)textFiledEditing:(UITextField*)sender{
    [sender resignFirstResponder];
}

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
    [deletekey release];
    [passArr release];
    [txtContext release];
    [txtTitle release];
    [super dealloc];
}

@end
