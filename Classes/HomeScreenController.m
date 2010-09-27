//
//  SplashController.m
//  TTCatalog
//
//  Created by Raed on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenController.h"

@implementation HomeScreenController

- (void)loadView
{
	[[self navigationController] setNavigationBarHidden:NO animated:YES];
	
	textFramePortrait =  CGRectMake(0.0f, 320.0f, 320.0f, 140.0f);
	textFrameLandscape =  CGRectMake(0.0f, 210.0f, 480.0f, 75.0f);
	
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	contentView = [[UIView alloc] initWithFrame:appFrame];
	contentView.backgroundColor = [UIColor blackColor];
	self.view = contentView;
    [contentView release]; 
	
	UIImage *image = [UIImage imageNamed:@"Pentagram_081710_0227_b.jpg"];
	myImage = [[UIImageView alloc] initWithImage:image];
	//myImage.frame = CGRectMake(0, 0, 320, 480);
	myImage.contentMode = UIViewContentModeCenter;
	[self.view addSubview:myImage];
	[myImage release];	
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    currentOrientation =  [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	NSLog(@"orientation %i",currentOrientation);
	
	frontLabel = [[UITextView alloc] initWithFrame:textFramePortrait];
	NSString *bio = @"Eddie Opara, has joined Pentagram as a partner. He becomes the seventh principal in Pentagram's New York office, where his team will be based. He joins Pentagram from his own studio, The Map Office, which he established in 2005.";
	frontLabel.text = bio;
	frontLabel.editable = NO;
	frontLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0f];
	frontLabel.textColor = [UIColor whiteColor];
	frontLabel.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
	myImage.autoresizesSubviews = YES;
	[self.view addSubview:frontLabel];
	[frontLabel setFrame:textFramePortrait];
	[frontLabel release];	
	
	UINavigationBar *bar = [self.navigationController navigationBar];
	self.title = @"Pentagram";
	bar.barStyle = UIBarStyleBlackOpaque;
		
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
}
-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	UINavigationBar *bar = [self.navigationController navigationBar];
	bar.barStyle = UIBarStyleBlackOpaque;	
}
//- (void) didRotate:(NSNotification *)notification
//{
//	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    currentOrientation =  [[UIDevice currentDevice] orientation];
//    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
//	[contentView setFrame:[[UIScreen mainScreen] applicationFrame]];
//	
//	myImage.contentMode = UIViewContentModeCenter;
//		
//	NSLog(@"orientationDID %i",currentOrientation);
//	if(currentOrientation == 0 || currentOrientation == 1 || currentOrientation == 2) 
//		[frontLabel setFrame:textFramePortrait];
//	else
//		[frontLabel setFrame:textFrameLandscape];
//}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return  (interfaceOrientation == (UIInterfaceOrientationPortrait || UIInterfaceOrientationPortraitUpsideDown));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

@end
