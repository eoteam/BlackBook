//
//  SplashController.m
//  TTCatalog
//
//  Created by Raed on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenController.h"

@implementation HomeScreenController
- (id)init
{
	if (self = [super init])
	{
		self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];

	}
	return self;
}	
- (void)loadView
{
	textFramePortrait =  CGRectMake(0.0f, 325.0f, 320.0f, 90.0f);
	textFrameLandscape =  CGRectMake(0.0f, 210.0f, 480.0f, 75.0f);
	
	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
	 
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	
	contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blackColor];
	contentView.autoresizesSubviews = YES;
	contentView.contentMode = UIViewContentModeCenter;
	//contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;
    [contentView release]; 
	
	UIImage *image = [UIImage imageNamed:@"Pentagram_081710_0227_b.jpg"];
	myImage = [[UIImageView alloc] initWithImage:image];
	myImage.opaque = YES; // explicitly opaque for performance
	
	myImage.contentMode = UIViewContentModeCenter;
	//CGRect rect = myImage.frame;
//	CGFloat w = myImage.size.width;
//	CGFloat h = myImage.size.height;
//	
//	rect.size.height = h;
//	rect.size.width = w; 
//	rect.origin.x = ((self.view.frame.size.width - image.size.width) / 2);
//	rect.origin.y = ((self.view.frame.size.height - image.size.height) / 2);
//	myImage.frame = rect; 
	
	myImage.autoresizesSubviews = YES;
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
	frontLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
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
- (void) didRotate:(NSNotification *)notification
{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    currentOrientation =  [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[contentView setFrame:[[UIScreen mainScreen] applicationFrame]];
	
	myImage.contentMode = UIViewContentModeCenter;
	//CGRect rect = myImage.frame;
//	CGFloat w = myImage.size.width;
//	CGFloat h = myImage.size.height;
//	
//	rect.size.height = h;
//	rect.size.width = w; 
//	rect.origin.x = (([[UIScreen mainScreen] applicationFrame].size.width - myImage.image.size.width) / 2);
//	rect.origin.y = (([[UIScreen mainScreen] applicationFrame].size.height - myImage.image.size.height) / 2);
//	myImage.frame = rect; 
	
	
	NSLog(@"orientationDID %i",currentOrientation);
	if(currentOrientation == 0 || currentOrientation == 1 || currentOrientation == 2) 
		[frontLabel setFrame:textFramePortrait];
	else
		[frontLabel setFrame:textFrameLandscape];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
		GridViewController *gridView = [[GridViewController alloc] init];
		[self.navigationController pushViewController:gridView animated:YES];
		[gridView release];
		
		UIBarButtonItem* _nextButton = [[[UIBarButtonItem alloc] initWithImage:TTIMAGE(@"19-gear.png")
										style:UIBarButtonItemStylePlain target:self action:nil] autorelease];
		
		UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
							 UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
		
		[self.navigationController setToolbarItems:[NSArray arrayWithObjects:space, _nextButton, nil]];
		
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

@end
