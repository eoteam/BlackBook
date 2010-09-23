//
//  ScrollingViewController.m
//  Scrolling
//
//  Created by David Janes on 09-09-25.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ScrollingViewController.h"
#import "MapViewController.h"

@implementation ScrollingViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize contentView;

#pragma mark -
#pragma mark UIView boilerplate
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
	
	
	UINavigationBar *bar = [self.navigationController navigationBar];
	bar.barStyle = UIBarStyleBlackOpaque;
}	
- (void)viewDidLoad 
{
	[self setupPage];
    [super viewDidLoad];
}
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
-(void)didRotate:(NSNotification *)notification
{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    currentOrientation =  [[UIDevice currentDevice] orientation];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	
	if(currentOrientation == 3 || currentOrientation == 4) {
		[scrollView setFrame: CGRectMake(0.0f,0.0f,480.0f,135.0f)];
		[pageControl setFrame:CGRectMake(0.0f, 124.0f,480.0f, 36.0f)];
		[contentView setFrame:CGRectMake(0.0f, 160.0f,480.0f, 160.0f)];	
	}
	else if(currentOrientation == 0 || currentOrientation == 1 || currentOrientation == 2) {
		[scrollView setFrame: CGRectMake(0.0f,0.0f,320.0f,204.0f)];
		[pageControl setFrame:CGRectMake(0.0f, 204.0f,320.0f, 36.0f)];
		[contentView setFrame:CGRectMake(0.0f, 240.0f,320.0f, 240.0f)];
	}
	CGFloat cx = 0;
	for (UIImageView *imageView in scrollView.subviews) {
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		UIImage *image = imageView.image;
		CGRect rect = imageView.frame;
		rect.size.height = image.size.height;
		rect.size.width = image.size.width;
		rect.origin.x = ((scrollView.frame.size.width - image.size.width) / 2) + cx;
		rect.origin.y = ((scrollView.frame.size.height - image.size.height) / 2);
		
		imageView.frame = rect;
		cx += scrollView.frame.size.width;
		
	}
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}
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
	
	CGRect f = CGRectMake(0.0f,0.0f,320.0f,204.0f);
	if(currentOrientation == 3 || currentOrientation == 4) {
		f = CGRectMake(0.0f,0.0f,480.0f,135.0f);
		[scrollView setFrame:f];
		[pageControl setFrame:CGRectMake(0.0f, 124.0f,480.0f, 36.0f)];
		[contentView setFrame:CGRectMake(0.0f, 160.0f,480.0f, 160.0f)];
	}
	CGFloat cx = 0;
	for (NSDictionary *img in images) {
		
		NSString *i =  [img objectForKey:@"name"];	
		//NSMutableString *path = [NSMutableString string];
		//[path appendString:@"bundle://"];
		//[path appendString:i];
		//NSLog(path);
		UIImage *image = [UIImage imageNamed:i];
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		CGRect rect = imageView.frame;
		CGFloat w = image.size.width;
		CGFloat h = image.size.height;
	
		rect.size.height = h;
		rect.size.width = w; 
		rect.origin.x = ((f.size.width - image.size.width) / 2) + cx;
		rect.origin.y = ((f.size.height - image.size.height) / 2);

		imageView.frame = rect;
		//NSLog("image size, w:%f h:%f",w,h);	
		[scrollView addSubview:imageView];
		[imageView release];

		cx += f.size.width;
	}
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
	
	self.pageControl.numberOfPages = [images count];
	//filePath = [[NSBundle mainBundle] pathForResource:@"office" ofType:@"html"];
	//fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
	[contentView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"office" ofType:@"html"]isDirectory:NO]]];

	//contentView.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0f];
	//[contentView setContentToHTMLString:fileContent];
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
    if (pageControlIsChangingPage) {
        return;
    }

	/*
	 *	We switch page at 50% across
	 */
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
