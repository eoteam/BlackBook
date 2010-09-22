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



// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[[self navigationController] setNavigationBarHidden:YES animated:NO];
	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
	
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

-(void) onTimer{
	NSLog(@"LOAD");
}

- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}


- (void) finishedFading
{
	
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	self.view.alpha = 1.0;   // fades the view to 1.0 alpha over 0.75 seconds
	viewController.view.alpha = 1.0;
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
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
/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
