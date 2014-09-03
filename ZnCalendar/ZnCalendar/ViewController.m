//
//  ViewController.m
//  ZnCalendar
//
//  Created by User on 11/09/2014.
//  Copyright (c) 2014 Waris. All rights reserved.
//

#import "ViewController.h"
#import "ZNCalendar.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)addLabelsToCalendar
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //,@"2014-02-1",@"2014-03-1",@"2014-04-1",@"2014-05-1",@"2014-06-1",@"2014-07-1",@"2014-08-1",@"2014-09-1",@"2014-10-1",@"2014-11-1",@"2014-12-1"
    
    ZNCalendar *znCal = [[ZNCalendar alloc]initWithNibName:@"ZNCalendar" bundle:nil];
    znCal.view.layer.borderWidth = 1.0;
    znCal.view.center = CGPointMake(160,200);
    [self addChildViewController:znCal];
    [self.view addSubview:znCal.view];
}

@end
