Calender
========


Simply in your viewController.m viewDidLoad event paste these lines

    ZNCalendar *znCal = [[ZNCalendar alloc]initWithNibName:@"ZNCalendar" bundle:nil];
    znCal.view.layer.borderWidth = 1.0;
    znCal.view.center = CGPointMake(160,200);
    [self addChildViewController:znCal];
    [self.view addSubview:znCal.view];