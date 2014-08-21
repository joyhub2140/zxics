//
//  repairDetail.m
//  zxics
//
//  Created by johnson on 14-8-18.
//  Copyright (c) 2014年 moko. All rights reserved.
//

#import "repairDetail.h"
#import "Commons.h"

@interface repairDetail ()

@end

@implementation repairDetail

@synthesize titleLabel;
@synthesize typeLabel;
@synthesize dateLabel;
@synthesize contentLabel;
@synthesize stateLabel;
@synthesize re;
@synthesize reSView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.UINavigationBar setBarTintColor:[UIColor colorWithRed:7.0/255.0 green:3.0/255.0 blue:164.0/255.0 alpha:1]];//设置bar背景颜色
    
    [self loaddata];
}

-(void)loaddata
{
    titleLabel.text=[re objectForKey:@"title"];
    
    Commons *_Commons=[[Commons alloc]init];
    dateLabel.text=[NSString stringWithFormat:@"期望维修时间：%@",[_Commons stringtoDate:[re objectForKey:@"addDate"]]];
    
    contentLabel.numberOfLines=0;
    CGSize size =CGSizeMake(contentLabel.frame.size.width,0);
    UIFont * tfont = contentLabel.font;
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    CGSize  actualsize =[[re objectForKey:@"contents"] boundingRectWithSize:size options:
                         NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    contentLabel.text=[NSString stringWithFormat:@"保修内容：%@",[re objectForKey:@"contents"]];
    contentLabel.frame=CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, actualsize.height+24);
    
    
    NSInteger repairsource=[[NSString stringWithFormat:@"%@",[re objectForKey:@"source"]] integerValue];
    NSString *status;
    if(repairsource==0)
    {
        status=@"未处理";
    }else if(repairsource==1)
    {
        status=@"已受理";
    }else if(repairsource==2)
    {
        status=@"已派员";
    }else if(repairsource==3)
    {
        status=@"维修完成";
    }else if(repairsource==4)
    {
        status=@"关闭";
    }
    stateLabel.text=[NSString stringWithFormat:@"保修状态：%@",status];
    stateLabel.frame=CGRectMake(stateLabel.frame.origin.x, contentLabel.frame.origin.y+contentLabel.frame.size.height, stateLabel.frame.size.width, stateLabel.frame.size.height);
    
    reSView.contentSize=CGSizeMake(320, contentLabel.frame.size.height+reSView.frame.size.height-250);
    reSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    reSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    reSView.scrollEnabled=YES;
    
}

-(IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end