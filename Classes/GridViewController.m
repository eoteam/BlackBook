#import "GridViewController.h"
#import "MockPhotoSource.h"
#import "TextViewController.h"

@implementation GridViewController


-(void) loadView {	
	[super loadView];
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
									 target:nil action:nil] autorelease];
	self.tableView.backgroundColor = [UIColor blackColor];
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = nil;
		
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}
- (void) didRotate:(NSNotification *)notification{  
		//Initialize the toolbar
		
		//Set the toolbar to fit the width of the app.
		[toolbar sizeToFit];
		
		//Caclulate the height of the toolbar
		CGFloat toolbarHeight = [toolbar frame].size.height;
		
		//Get the bounds of the parent view
		CGRect rootViewBounds = self.parentViewController.view.bounds;
		
		//Get the height of the parent view.
		CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
		
		//Get the width of the parent view,
		CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
		
		//Create a rectangle for the toolbar
		CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
		
		//Reposition and resize the receiver
		[toolbar setFrame:rectArea];	
}
-(void) viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	if(isModal == NO) {
		//Initialize the toolbar
		toolbar = [[UIToolbar alloc] init];
		toolbar.barStyle =  UIBarStyleBlackTranslucent;
	
		//Set the toolbar to fit the width of the app.
		[toolbar sizeToFit];
	
		//Caclulate the height of the toolbar
		CGFloat toolbarHeight = [toolbar frame].size.height;
	
		//Get the bounds of the parent view
		CGRect rootViewBounds = self.parentViewController.view.bounds;
	
		//Get the height of the parent view.
		CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
	
		//Get the width of the parent view,
		CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	
		//Create a rectangle for the toolbar
		CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
	
		//Reposition and resize the receiver
		[toolbar setFrame:rectArea];	
	
	
		UIBarButtonItem* _nextButton = [[[UIBarButtonItem alloc] initWithImage:
									 [UIImage imageNamed:@"19-gear.png"]
																	 style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)] autorelease];
	
		UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
						 UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	
	
		[toolbar setItems:[NSArray arrayWithObjects:space, _nextButton, nil]];
	
		[self.navigationController.view addSubview:toolbar];
				
	}
	else {
		//Set the toolbar to fit the width of the app.
		[toolbar sizeToFit];
		
		//Caclulate the height of the toolbar
		CGFloat toolbarHeight = [toolbar frame].size.height;
		
		//Get the bounds of the parent view
		CGRect rootViewBounds = self.parentViewController.view.bounds;
		
		//Get the height of the parent view.
		CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
		
		//Get the width of the parent view,
		CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
		
		//Create a rectangle for the toolbar
		CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
		
		//Reposition and resize the receiver
		[toolbar setFrame:rectArea];	
	}
	isModal = NO;
}
- (void)viewDidLoad {
	isModal = NO;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
	NSDictionary *results = [fileContent JSONValue];
	NSArray *temp = [results objectForKey:@"images"];
	images = [NSMutableArray array];
	
 	for (NSDictionary *img in temp) {
		
		NSString *copy1 =  [img objectForKey:@"name"];	
		NSMutableString *thumb = [NSMutableString string];
		[thumb appendString:@"bundle://th_"];
		[thumb appendString:copy1];
		
		NSMutableString *image = [NSMutableString string]; 
		[image appendString: @"bundle://"];
		[image appendString:copy1];
		[images addObject:	[[[MockPhoto alloc]
							  initWithURL:image
							  smallURL:thumb
							  size:CGSizeMake([[img objectForKey:@"wratio"] intValue], [[img objectForKey:@"hratio"] intValue])
							  caption:[img objectForKey:@"info"]] autorelease]];	
	}
    self.photoSource = [[MockPhotoSource alloc]
						initWithType:MockPhotoSourceNormal
						//initWithType:MockPhotoSourceDelayed
						// initWithType:MockPhotoSourceLoadError
						// initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
						title:@"Eddie Opara"
						photos:images
						photos2:nil
						];
}
-(void) showAlert {
	// open an alert with just an OK button
	// open a dialog with two custom buttons
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Info"
										delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil
										otherButtonTitles:@"Bio", @"Credits",@"New York Office", nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];	

}
//UIAlert methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	printf("User Pressed Button %d\n", buttonIndex);
	if (buttonIndex == 0) {
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bio" ofType:@"json"];
		NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
		NSDictionary *results = [fileContent JSONValue];
		NSString *bio = [results objectForKey:@"bio"];
		TextViewController *controller = [[TextViewController alloc] initWithContent:bio];
		
		
		UINavigationController *newNavController = [[UINavigationController alloc]
													initWithRootViewController:controller];
		
		newNavController.navigationBar.barStyle = UIBarStyleBlackOpaque;
		[[self navigationController] presentModalViewController:newNavController
													   animated:YES];
		
		[controller release];
		isModal = TRUE;
	}
	else if(buttonIndex == 1) {
		NSLog(@"OK THEN");
		NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"json"];
		NSString *fileContent2 = [[NSString alloc] initWithContentsOfFile:filePath2];
		NSDictionary *results2 = [fileContent2 JSONValue];
		NSString *credits = [results2 objectForKey:@"credits"];
		NSLog(credits);
		TextViewController *controller = [[TextViewController alloc] initWithContent:credits];
		
		
		UINavigationController *newNavController = [[UINavigationController alloc]
													initWithRootViewController:controller];
		newNavController.navigationBar.barStyle = UIBarStyleBlackOpaque;
		[[self navigationController] presentModalViewController:newNavController
													   animated:YES];
		[controller release];
		isModal = YES;	
	}
		else if(buttonIndex == 2) {
			NSLog(@"OK THEN2");
			//NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"json"];
//			NSString *fileContent2 = [[NSString alloc] initWithContentsOfFile:filePath2];
//			NSDictionary *results2 = [fileContent2 JSONValue];
//			NSString *credits = [results2 objectForKey:@"credits"];
//			NSLog(credits);
//			
//			ScrollingViewController *controller = [[ScrollingViewController alloc] init];
//			
//			
//			UINavigationController *newNavController = [[UINavigationController alloc]
//														initWithRootViewController:controller];
//			newNavController.navigationBar.barStyle = UIBarStyleBlackOpaque;
//			[[self navigationController] presentModalViewController:newNavController
//														   animated:YES];
//			[controller release];
//			isModal = YES;				
		}
}
-(void) dealloc {
	[toolbar removeFromSuperview];
	[super dealloc];
}

- (void)thumbsTableViewCell:(TTThumbsTableViewCell*)cell didSelectPhoto:(id<TTPhoto>)photo {
	
	[super thumbsTableViewCell:cell didSelectPhoto:photo];
	[toolbar removeFromSuperview];	
  
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
@end
