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

#pragma mark -
#pragma mark UIView boilerplate

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
	

	//  NSString* kText = @"\
	//<span class=\"largeText\">font sizes</span>a";
	//  NSString* kText = @"<span class=\"largeText\">bah</span><span class=\"inlineBox\">hyper links</span>";
	//  NSString* kText = @"blah blah blah black sheep blah <span class=\"inlineBox\">\
	//<img src=\"bundle://smiley.png\"/>hyperlinks</span> blah fun";
	//  NSString* kText = @"\
	//<div class=\"inlineBox\"><div class=\"inlineBox2\">You can enclose blocks within an HTML div.</div></div>";
	//  NSString* kText = @"\
	//<span class=\"inlineBox\"><span class=\"inlineBox2\">You can enclose blocks within an HTML div.</span></span>x";
	//  NSString* kText = @"<b>bold text</b> <span class=\"largeText\">font http://foo.com sizes</span>";
	//  NSString* kText = @"<a href=\"x\"><img src=\"bundle://smiley.png\"/></a> This is some text";
	//  NSString* kText = @"\
	//<img src=\"bundle://smiley.png\" class=\"floated\" width=\"50\" height=\"50\"/>This \
	//is a test of floats. This is still a test of floats.  This text will wrap itself around \
	//the image that is being floated on the left.  I repeat, this is a test of floats.";
	//  NSString* kText = @"\
	//<span class=\"floated\"><img src=\"bundle://smiley.png\" width=\"50\" height=\"50\"/></span>This \
	//is a test of floats. This is still a test of floats.  This text will wrap itself around \
	//the image that is being floated on the left.  I repeat, this is a test of floats.";
	//  NSString* kText = @"\
	//<a>Bob Bobbers</a> <span class=\"smallText\">at 4:30 pm</span><br>Testing";
	
	// XXXjoe This illustrates the need to calculate a line's descender height as well @1079
	// NSString* kText = @"<span class=\"largeText\">bah</span> <span class=\"smallText\">humbug</span>";
	
//	CGRect f = CGRectMake(0.0f,240.0f,320.0f,240.0f);
//	TTStyledTextLabel* label1 = [[[TTStyledTextLabel alloc] initWithFrame:f] autorelease];
//	label1.font = [UIFont systemFontOfSize:17];
//	label1.text = [TTStyledText textFromXHTML:kText lineBreaks:YES URLs:YES];
//	label1.backgroundColor = [UIColor blackColor];
//	label1.textColor = [UIColor whiteColor];
//	label1.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
//	label1.sh
//	//label1.backgroundColor = [UIColor grayColor];
//	[label1 sizeToFit];
//	[self.view addSubview:label1];
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
- (void)setupPage
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"nyoffice" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
	NSLog(fileContent);
	NSDictionary *results = [fileContent JSONValue];
	NSArray *images = [results objectForKey:@"images"];
	
	scrollView.delegate = self;

	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	NSUInteger count = 0;
	CGFloat cx = 0;
	for (NSDictionary *img in images) {
		
		NSString *i =  [img objectForKey:@"name"];	
		//NSMutableString *path = [NSMutableString string];
		//[path appendString:@"bundle://"];
		//[path appendString:i];
		//NSLog(path);
		UIImage *image = [UIImage imageNamed:i];
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect rect = imageView.frame;
		//NSLog("image size, w:%d h:%d",image.size.width,image.size.height);
		rect.size.height = image.size.height;
		rect.size.width = image.size.width;
		rect.origin.x = ((scrollView.frame.size.width - image.size.width) / 2) + cx;
		rect.origin.y = ((scrollView.frame.size.height - image.size.height) / 2);

		imageView.frame = rect;

		[scrollView addSubview:imageView];
		[imageView release];

		cx += scrollView.frame.size.width;
	}

	self.pageControl.numberOfPages = [images count];
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
	
	NSString* kText = @"<p>204 Fifth Avenue<br /> \
	New York NY 10010</p> \
	<p>T +212 683 7000<br />F +212 532 0181<br />E <a href=\"mailto:info@pentagram.com\">info@pentagram.com</a></p> \
	<h3>Location</h3> \
	<p>Flatiron district. Our office is a five-story building between 25th and 26th Streets, directly across from Madison Square Park.</p> \
	<h3>Directions via public transport</h3> \
	<p>From N/R/W subway station at 23rd Street, walk north two blocks from the intersection of Fifth Avenue and Broadway. Our building is marked with a letter P banner.</p> \
	<p></p><p></p><p></p><p></p>";
	
	[contentView setContentToHTMLString:kText];
	contentView.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0f];

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
