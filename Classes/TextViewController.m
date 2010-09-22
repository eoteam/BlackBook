//
//  TextViewController.m
//  Pentagram
//
//  Created by raed on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextViewController.h"


@implementation TextViewController

- (NSString *)content { 
	return content;
} 
- (void)setContent:(NSString *)value {
	content = value;
}

- (id)init { 
	return [self initWithContent:@"CRAAP"];
}	
-(id) initWithContent:(NSString *)c 
{
	if (self = [super init])
	{
		self.title = @"Eddie Opara";
		[self setContent: c];

		textView = [[UITextView alloc] initWithFrame:self.view.bounds];
		textView.text = content;
		textView.editable = NO;
		textView.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
		textView.textColor = [UIColor whiteColor];
		textView.backgroundColor = [UIColor blackColor];
		textView.autoresizesSubviews = YES;
		self.view = textView;	
		[textView release];		
	}
	return self;	
}
-(void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	UINavigationBar *bar = [self.navigationController navigationBar];
	bar.barStyle = UIBarStyleBlackOpaque;	
}	
-(void) loadView {	
	UINavigationBar *bar = [self.navigationController  navigationBar];
	bar.barStyle = UIBarStyleBlackTranslucent;	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}
- (void) didRotate:(NSNotification *)notification
{  
	[textView setFrame:self.view.bounds];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}
- (void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
