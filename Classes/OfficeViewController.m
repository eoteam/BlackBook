//
//  ScrollingViewController.m
//  Scrolling
//
//  Created by David Janes on 09-09-25.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "OfficeViewController.h"
#import "MapViewController.h"

@implementation OfficeViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize contentView;

#pragma mark -
#pragma mark UIView boilerplate
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return  (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
-(void) loadView
{
	[super loadView];
	self.title = @"New York Office";
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
									 target:nil action:nil] autorelease];
	UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] 
											 initWithTitle:@"Map"
											 style: UIBarButtonItemStyleBordered
											 target:self 
											 action:@selector(showMap)];
	[[self navigationItem] setRightBarButtonItem:mapButton];
	[mapButton release];
	UINavigationBar *bar = [self.navigationController navigationBar];
	bar.barStyle = UIBarStyleBlackOpaque;
}	
- (void) viewWillAppear:(BOOL)animated
{	
    [super viewWillAppear:animated];
	[self setupPage];
}
//- (void)viewDidLoad
//{	
//    [super viewDidLoad];
//	[self setupPage];
//}
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
	[scrollView release];
	[pageControl release];
	[contentView release];
}
- (void)dealloc 
{	
    [super dealloc];
}

#pragma mark -
#pragma mark The Guts
- (void)setupPage
{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    currentOrientation =  [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nyoffice" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
	NSDictionary *results = [fileContent JSONValue];
	images  = [results objectForKey:@"images"];
	
	scrollView.delegate = self;

	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	int w = 320; 
	int h = 204;	
	CGFloat cx = 0;
	int i = 0;
	for (NSDictionary *img in images) {		
		NSString *file =  [img objectForKey:@"name"];	
		UIImage *image = [UIImage imageNamed:file];		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.clipsToBounds = YES;
		imageView.frame = CGRectMake( w * i++, 0, w, h);		
		[scrollView addSubview:imageView];
		[imageView release];
		cx += w;
	}
	[scrollView setContentSize:CGSizeMake(cx, h)];
	[scrollView setFrame:CGRectMake(0, 0, w, h)];
	//[contentView setContentSize:CGSizeMake(w, h)];
	self.pageControl.numberOfPages = [images count];
	[contentView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"office" ofType:@"html"]isDirectory:NO]]];
}
-(void) showMap
{
	MapViewController *controller = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];	
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];	
}


#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage)
	{
        return;
    }
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender 
{
	/*
	 *	Change the scroll view
	 */
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];

	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
}

@end
