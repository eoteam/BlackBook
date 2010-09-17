#import "PhotoTest2Controller.h"
#import "MockPhotoSource.h"

@implementation PhotoTest2Controller

-(void) loadView {	
	[super loadView];
	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
									 target:nil action:nil] autorelease];
	self.tableView.backgroundColor = [UIColor blackColor];
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
	self.navigationBarTintColor = nil;
	
	
	self.navigationBarStyle = UIBarStyleBlackTranslucent;
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
	
	//Reload the table view
	//[self.tableView reloadData];	
									  
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
-(void) dealloc {
	[toolbar removeFromSuperview];
	[super dealloc];
}
- (void)viewDidLoad {


	
  self.photoSource = [[MockPhotoSource alloc]
    initWithType:MockPhotoSourceNormal
    //initWithType:MockPhotoSourceDelayed
    // initWithType:MockPhotoSourceLoadError
    // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
    title:@"Eddie Opara"
    photos:[[NSArray alloc] initWithObjects:
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
      size:CGSizeMake(960, 1280)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
      smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"A hike."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
      smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
      size:CGSizeMake(383, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
      smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
      smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
      size:CGSizeMake(407, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
      smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
      size:CGSizeMake(500, 406)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
      smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
      size:CGSizeMake(500, 372)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
      smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
      size:CGSizeMake(960, 1280)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
      smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"A hike."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
      smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
      size:CGSizeMake(383, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
      smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
      smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
      size:CGSizeMake(407, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
      smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
      size:CGSizeMake(500, 406)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
      smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
      size:CGSizeMake(500, 372)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
      smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
      size:CGSizeMake(960, 1280)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
      smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"A hike."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
      smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
      size:CGSizeMake(383, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
      smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
      smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
      size:CGSizeMake(407, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
      smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
      size:CGSizeMake(500, 406)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
      smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
      size:CGSizeMake(500, 372)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
      smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
      size:CGSizeMake(960, 1280)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
      smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"A hike."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
      smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
      size:CGSizeMake(383, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
      smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
      smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
      size:CGSizeMake(407, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
      smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
      size:CGSizeMake(500, 406)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
      smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
      size:CGSizeMake(500, 372)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
      smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
      size:CGSizeMake(960, 1280)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
      smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
      smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
      size:CGSizeMake(320, 480)
      caption:@"A hike."] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
      smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
      size:CGSizeMake(320, 480)] autorelease],

    [[[MockPhoto alloc]
      initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
      smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
      size:CGSizeMake(383, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
      smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
      size:CGSizeMake(391, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
      smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
      size:CGSizeMake(407, 500)] autorelease],
    [[[MockPhoto alloc]
      initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
      smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
      size:CGSizeMake(500, 406)] autorelease],

    nil
  ]

  photos2:nil
//  photos2:[[NSArray alloc] initWithObjects:
//    [[[MockPhoto alloc]
//      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
//      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
//      size:CGSizeMake(800, 533)] autorelease],
//    nil]
  ];
}

@end
