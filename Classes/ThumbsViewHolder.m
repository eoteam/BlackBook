    //
//  ThumbsViewHolder.m
//  Pentagram
//
//  Created by raed on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ThumbsViewHolder.h"


@implementation ThumbsViewHolder

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
	
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor blackColor];
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;
	
//	
//	CGRect innerFrame = CGRectMake(0, 0,
//								   screenFrame.size.width, screenFrame.size.height);
//	_innerView = [[UIView alloc] initWithFrame:innerFrame];
//	_innerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//	[self.view addSubview:_innerView];
//	
//	_infoButton = [[UIBarButtonItem alloc] initWithImage:TTIMAGE(@"19-gear.png") 
//												   style:UIBarButtonItemStylePlain 
//												  target:self ];
//	UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
//						 UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
//	_toolbar = [[UIToolbar alloc] initWithFrame:
//				CGRectMake(0, screenFrame.size.height - TT_ROW_HEIGHT,
//						   screenFrame.size.width, TT_ROW_HEIGHT)];
//	//if (self.navigationController.navigationBarStyle == UIBarStyleDefault) {
//	//	_toolbar.tintColor = TTSTYLEVAR(toolbarTintColor);
//	//}
//	
//	//_toolbar.barStyle = self.navigationController.navigationBarStyle;
//	_toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//	_toolbar.items = [NSArray arrayWithObjects:
//					  space, _infoButton, nil];
//
//	[_innerView addSubview:_toolbar];	
//	
	PhotoTest2Controller *gridView = [[PhotoTest2Controller alloc] init];
	
	[self.view addSubview:gridView];
	
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

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
