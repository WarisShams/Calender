//
//  ZNCalendar.m
//  ZnCalendar
//
//  Created by User on 14/08/2014.
//  Copyright (c) 2014 Waris. All rights reserved.
//

#import "ZNCalendar.h"

@interface ZNCalendar ()
{
    int currentMonth;
    int currentYear;
    IBOutlet UILabel *titleDateLabel;
}
@end

@implementation ZNCalendar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)next:(id)sender
{
    if (currentMonth < 12)
    {
        currentMonth ++;
    }
    else
    {
        currentMonth = 1;
        currentYear++;
    }

    [self setupCalendar:[NSString stringWithFormat:@"%i-0%i-01",currentYear,currentMonth]];
}

-(IBAction)previous:(id)sender
{
    if (currentMonth > 1)
    {
        currentMonth --;
    }
    else
    {
        currentMonth = 12;
        currentYear--;
    }

    
    [self setupCalendar:[NSString stringWithFormat:@"%i-0%i-01",currentYear,currentMonth]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentMonth = 1;
    currentYear = 2014;
    
    [self setupCalendar:[NSString stringWithFormat:@"%i-0%i-01",currentYear,currentMonth]];
}

-(void)setupCalendar:(NSString *)string
{
    for (UILabel * subview in self.view.subviews)
    {
        if (subview.tag == 100) {
            [subview removeFromSuperview];
        }
    }
    
    NSDate *firstDate = [self getDateFromString:string];
    NSString *firstDay = [self getDayNameFor:firstDate];
    
    [self setupDatesBefore:firstDay andFirstDate:firstDate];
    
    CGPoint firstPoint = [self getPointForDay:firstDay forWeek:1];
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstPoint.x, firstPoint.y, 36, 40)];
    firstLabel.text = @"1";
    firstLabel.tag = 100;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.backgroundColor = [UIColor whiteColor];
    firstLabel.textColor = [UIColor colorWithRed:241/255.0 green:95/255.0 blue:116/255.0 alpha:1.0];
    firstLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:firstLabel];
    
    int totalDays = [self numberOfDaysInMonth:firstDate];
    int totalWeeks = [self getNumberOfWeeks:totalDays];
    int currentWeek = 1;
    NSString *newDay;
    NSDate *newDate;
    
    for (int i = 1; i<totalDays; i++)
    {
        newDate = [self addDayToDate:firstDate andDays:i];
        newDay = [self getDayNameFor:newDate];
        
        if([newDay isEqualToString:@"Sunday"])
            currentWeek++;
        
        CGPoint newPoint = [self getPointForDay:newDay forWeek:currentWeek];
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(newPoint.x, newPoint.y, 36, 40)];
        newLabel.text = [NSString stringWithFormat:@"%i",i+1];
        newLabel.tag = 100;
        newLabel.textAlignment = NSTextAlignmentCenter;
        newLabel.backgroundColor = [UIColor whiteColor];
        newLabel.textColor = [UIColor colorWithRed:241/255.0 green:95/255.0 blue:116/255.0 alpha:1.0];
        newLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        [self.view addSubview:newLabel];
    }
    
    [self setupDatesAfter:newDay andWeek:currentWeek andLastDate:newDate];
    titleDateLabel.text = [NSString stringWithFormat:@"%@ %i",[self getMonthNameFor:currentMonth],currentYear];

}

-(int)getNumberOfWeeks:(int)totalDays
{
    CGFloat weeksFloat = totalDays/7.0;
    int weeksInt = totalDays/7;
    if (weeksFloat > weeksInt) {
        weeksInt++;
    }
    
    return weeksInt;
}

-(NSDate *)getDateFromString:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0:00"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = [dateFormatter dateFromString:date];
    
    return newDate;
}

-(NSDate *)addDayToDate:(NSDate *)date andDays:(int)i
{
    return [date dateByAddingTimeInterval:60*60*24*i];
}

-(int)numberOfDaysInMonth:(NSDate *)date
{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:date];
    
    return (int)days.length;
}

-(NSString *)getDayNameFor:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0:00"]];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:date];
    return dayName;
}

-(CGPoint)getPointForDay:(NSString *)day forWeek:(int)week
{
    CGPoint p;
    int y = 0;
    switch (week) {
        case 1:
        {
            y = 81;
        }
            break;
        case 2:
        {
            y = 122;
        }
            break;
        case 3:
        {
            y = 163;
        }
            break;
        case 4:
        {
            y = 204;
        }
            break;
        case 5:
        {
            y = 245;
        }
            break;
        case 6:
        {
            y = 286;
        }
            break;
            
        default:
            break;
    }
    
    int x = 0;
    if ([day isEqualToString:@"Sunday"])
    {
        x = 0;
    }
    if ([day isEqualToString:@"Monday"])
    {
        x = 37;
    }
    if ([day isEqualToString:@"Tuesday"])
    {
        x = 74;
    }
    if ([day isEqualToString:@"Wednesday"])
    {
        x = 111;
    }
    if ([day isEqualToString:@"Thursday"])
    {
        x = 148;
    }
    if ([day isEqualToString:@"Friday"])
    {
        x = 185;
    }
    if ([day isEqualToString:@"Saturday"])
    {
        x = 222;
    }
    
    p = CGPointMake(x, y);
    return p;
}


-(NSString *)getMonthNameFor:(int)monthNumber
{
    NSString *string = @"";
    switch (monthNumber) {
        case 1:
            string = @"Jan";
            break;
        case 2:
            string = @"Feb";
            break;
        case 3:
            string = @"Mar";
            break;
        case 4:
            string = @"Apr";
            break;
        case 5:
            string = @"May";
            break;
        case 6:
            string = @"Jun";
            break;
        case 7:
            string = @"Jul";
            break;
        case 8:
            string = @"Aug";
            break;
        case 9:
            string = @"Sep";
            break;
        case 10:
            string = @"Oct";
            break;
        case 11:
            string = @"Nov";
            break;
        case 12:
            string = @"Dec";
            break;
            
        default:
            break;
    }
    
    return string;
}

#pragma mark - First

-(void)setupDatesBefore:(NSString *)firstDayofMonth andFirstDate:(NSDate *)firstDate
{
    int days = [self numberOfDayPreviousMonthBeforeFirstDate:firstDayofMonth];
    for (int i= 1; i<=days; i++)
    {
        NSDate *date = [self addDayToDate:firstDate andDays:-i];
        NSString *newDay = [self getDayNameFor:date];
        CGPoint newPoint = [self getPointForDay:newDay forWeek:1];
        UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(newPoint.x, newPoint.y, 36, 40)];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        NSInteger day = [components day];
        
        newLabel.text = [NSString stringWithFormat:@"%i",day];
        newLabel.tag = 100;
        newLabel.textAlignment = NSTextAlignmentCenter;
        newLabel.backgroundColor = [UIColor whiteColor];
        newLabel.textColor = [UIColor lightGrayColor];
        newLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        [self.view addSubview:newLabel];
        NSLog(@"Previous Date: %@",date);
    }
}

-(void)setupDatesAfter:(NSString *)lastDayofMonth andWeek:(int)lastWeek andLastDate:(NSDate *)lastDate
{
    if (lastWeek == 5)
    {
        int days = [self numberOfDayAfterMonthAfterLastDate:lastDayofMonth];
        for (int i= 1; i<=days; i++)
        {
            NSDate *date = [self addDayToDate:lastDate andDays:i];
            NSString *newDay = [self getDayNameFor:date];
            CGPoint newPoint = [self getPointForDay:newDay forWeek:5];
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(newPoint.x, newPoint.y, 36, 40)];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
            NSInteger day = [components day];
            
            newLabel.text = [NSString stringWithFormat:@"%i",day];
            newLabel.tag = 100;
            newLabel.textAlignment = NSTextAlignmentCenter;
            newLabel.backgroundColor = [UIColor whiteColor];
            newLabel.textColor = [UIColor lightGrayColor];
            newLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
            [self.view addSubview:newLabel];
            NSLog(@"Previous Date: %@",date);
        }
        for (int i= days; i<=days+7; i++)
        {
            NSDate *date = [self addDayToDate:lastDate andDays:i];
            NSString *newDay = [self getDayNameFor:date];
            CGPoint newPoint = [self getPointForDay:newDay forWeek:6];
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(newPoint.x, newPoint.y, 36, 40)];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
            NSInteger day = [components day];
            
            newLabel.text = [NSString stringWithFormat:@"%i",day];
            newLabel.tag = 100;
            newLabel.textAlignment = NSTextAlignmentCenter;
            newLabel.backgroundColor = [UIColor whiteColor];
            newLabel.textColor = [UIColor lightGrayColor];
            newLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
            [self.view addSubview:newLabel];
            NSLog(@"Previous Date: %@",date);
        }
    }
    
    if (lastWeek == 6)
    {
        int days = [self numberOfDayAfterMonthAfterLastDate:lastDayofMonth];
        for (int i= 1; i<=days; i++)
        {
            NSDate *date = [self addDayToDate:lastDate andDays:i];
            NSString *newDay = [self getDayNameFor:date];
            CGPoint newPoint = [self getPointForDay:newDay forWeek:6];
            UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(newPoint.x, newPoint.y, 36, 40)];
            
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
            NSInteger day = [components day];
            
            newLabel.text = [NSString stringWithFormat:@"%i",day];
            newLabel.tag = 100;
            newLabel.textAlignment = NSTextAlignmentCenter;
            newLabel.backgroundColor = [UIColor whiteColor];
            newLabel.textColor = [UIColor lightGrayColor];
            newLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
            [self.view addSubview:newLabel];
            NSLog(@"Previous Date: %@",date);
        }

    }
}


-(int)numberOfDayPreviousMonthBeforeFirstDate:(NSString *)day
{
    int x = 0;
    if ([day isEqualToString:@"Sunday"])
    {
        x = 0;
    }
    if ([day isEqualToString:@"Monday"])
    {
        x = 1;
    }
    if ([day isEqualToString:@"Tuesday"])
    {
        x = 2;
    }
    if ([day isEqualToString:@"Wednesday"])
    {
        x = 3;
    }
    if ([day isEqualToString:@"Thursday"])
    {
        x = 4;
    }
    if ([day isEqualToString:@"Friday"])
    {
        x = 5;
    }
    if ([day isEqualToString:@"Saturday"])
    {
        x = 6;
    }

    return x;
}

-(int)numberOfDayAfterMonthAfterLastDate:(NSString *)day
{
    int x = 0;
    if ([day isEqualToString:@"Sunday"])
    {
        x = 6;
    }
    if ([day isEqualToString:@"Monday"])
    {
        x = 5;
    }
    if ([day isEqualToString:@"Tuesday"])
    {
        x = 4;
    }
    if ([day isEqualToString:@"Wednesday"])
    {
        x = 3;
    }
    if ([day isEqualToString:@"Thursday"])
    {
        x = 2;
    }
    if ([day isEqualToString:@"Friday"])
    {
        x = 1;
    }
    if ([day isEqualToString:@"Saturday"])
    {
        x = 0;
    }
    
    return x;
}


@end
