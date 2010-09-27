//
//  SplashViewController.m
//  iTennis
//
//  Created by Brandon Trebitowski on 3/18/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"


@implementation SplashViewController

@synthesize timer,splashImageView,viewController;
	
- (id)init
{
    if (self = [super init]) {
        self.title = @"Pentagram";
		[[self navigationController] setNavigationBarHidden:YES animated:NO];
    }
    return self;
}
- (void)loadView
{
	[[self navigationController] setNavigationBarHidden:YES animated:NO];
	
	//[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
	// Init the view
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:appFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	self.view = view;
	[view release];
	
	splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
	splashImageView.frame = CGRectMake(0, 0, 320, 480);
	[self.view addSubview:splashImageView];
	
	viewController = [[HomeScreenController alloc] init];
	viewController.view.alpha = 0.0;
	[self.view addSubview:viewController.view];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
}

-(void) onTimer
{
	NSLog(@"LOAD");
}
- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; 
	[UIView setAnimationDuration:0.75];      
	[UIView setAnimationDelegate:self];  
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];  
	self.view.alpha = 0.0;  
	[UIView commitAnimations];
}
- (void) finishedFading
{	
	[UIView beginAnimations:nil context:nil]; 
	[UIView setAnimationDuration:0.75];
	self.view.alpha = 1.0;
	viewController.view.alpha = 1.0;
	[UIView commitAnimations];
	[splashImageView removeFromSuperview];
	self.title = @"Pentagram";
	UINavigationBar *bar = [self.navigationController navigationBar];
	self.title = @"Pentagram";
	bar.barStyle = UIBarStyleBlackOpaque;
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"CLICK");
	GridViewController *gridView = [[GridViewController alloc] init];
	[self.navigationController pushViewController:gridView animated:YES];
	[gridView release];
}
-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	UINavigationBar *bar = [self.navigationController navigationBar];
	bar.barStyle = UIBarStyleBlackOpaque;	
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return  (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc 
{
	[viewController release];
    [super dealloc];
}
@end
