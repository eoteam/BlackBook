//
//  SplashController.m
//  TTCatalog
//
//  Created by Raed on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CatalogController.h"

@implementation CatalogController
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
	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
	
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blackColor];
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;
	
    [contentView release]; 
	
	
	UIImageView *myImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
	[myImage setImage:[UIImage imageNamed:@"Pentagram_081710_0227_b.jpg"]];
	myImage.opaque = YES; // explicitly opaque for performance
	myImage.contentMode =    UIViewContentModeCenter; 
	[self.view addSubview:myImage];
	[myImage release];	
	
	
	CGRect labelFrame = CGRectMake(0.0f, 320.0f, 320.0f, 160.0f);
	UITextView *frontLabel = [[UITextView alloc] initWithFrame:labelFrame];
	NSString *bio = @"Eddie Opara, has joined Pentagram as a partner. He becomes the seventh principal in Pentagram's New York office, where his team will be based. He joins Pentagram from his own studio, The Map Office, which he established in 2005.";
	frontLabel.text = bio;
	frontLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
	frontLabel.textColor = [UIColor whiteColor];
	frontLabel.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
	[myImage addSubview:frontLabel];
	[frontLabel release];	
	
	
	UINavigationBar *bar = [self.navigationController navigationBar];
	[bar setBackgroundColor:[UIColor blackColor]];
	self.title = @"Pentagram";
	bar.barStyle = UIBarStyleBlackTranslucent;
	
	//[self.navigationController setToolbarHidden:TRUE animated:TRUE];
	//self.navigationItem.navigationBarStyle = UIBarStyleBlackTranslucent;
	//self.navigationItem.navigationBarTintColor = nil;
	
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
									 target:nil action:nil] autorelease];
	
}
	 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
	{
		PhotoTest2Controller *gridView = [[PhotoTest2Controller alloc] init];
		// ...
		// Pass the selected object to the new view controller.
		
		[self.navigationController pushViewController:gridView animated:YES];
		[gridView release];
		
		UIBarButtonItem* _nextButton = [[[UIBarButtonItem alloc] initWithImage:
										 TTIMAGE(@"19-gear.png")
																		 style:UIBarButtonItemStylePlain target:self action:nil] autorelease];
		
		UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
							 UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
		
		[self.navigationController setToolbarItems:[NSArray arrayWithObjects:
													space, _nextButton, nil]];
		
	}
	 
// Allow the view to respond to iPhone Orientation changes
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

// Add any memory warning issues by releasing non-essential data
//- (void)didReceiveMemoryWarning {
//	// releases the view if it is not attached to a super view
//    [super didReceiveMemoryWarning]; 
//}
//
//-(void) dealloc
//{
//	[super dealloc];
//}
@end
