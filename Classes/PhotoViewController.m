//
//  PhotoViewController.m
//  Pentagram
//
//  Created by raed on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "TextViewController.h"
#import "MockPhotoSource.h"
#import "OfficeViewController.h"

@implementation PhotoViewController

- (void)showBars:(BOOL)show animated:(BOOL)animated {
	[super showBars:show animated:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)loadView {
	
	[super loadView];
	
	UIButton *helpButton =  [UIButton buttonWithType:UIButtonTypeInfoLight ] ;
	[helpButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem* infoButton = [[[UIBarButtonItem alloc] initWithCustomView:helpButton] autorelease];
	
	UIBarItem* space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
						 UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	
	UIBarButtonItem *emailButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
																				 target:self
																				 action:@selector(showEmailMenu)] autorelease];
	
	NSMutableArray *toolbarItems = [NSMutableArray array];
	[toolbarItems addObject:emailButton];
	[toolbarItems addObject:space];
	NSArray *items = _toolbar.items;
	for (id *button in items) {
		[toolbarItems addObject:button];
	}
	[toolbarItems addObject:space];
	[toolbarItems addObject:infoButton];
	NSLog(@"%d",toolbarItems.count);
	[_toolbar setItems:toolbarItems];

	self.navigationItem.backBarButtonItem =
	[[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered
									 target:nil action:nil] autorelease];	
	
}
- (void)updateChrome {
	[super updateChrome];
	self.navigationItem.rightBarButtonItem = nil;
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
-(void) showEmailMenu {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share"
															 delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil
													otherButtonTitles:@"Email",@"Save to Library", nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
	[actionSheet release];	
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *menuTitle = [actionSheet title];
	if (menuTitle == @"Info") {
		if (buttonIndex == 0) {
			NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bio" ofType:@"json"];
			NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath];
			NSDictionary *results = [fileContent JSONValue];
			NSString *bio = [results objectForKey:@"bio"];
			TextViewController *controller = [[TextViewController alloc] initWithContent:bio];
			
			
			//UINavigationController *newNavController = [[UINavigationController alloc]
			//													initWithRootViewController:controller];
			//		
			//		newNavController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			//		[[self navigationController] presentModalViewController:newNavController
			//													   animated:YES];
			[self.navigationController pushViewController:controller animated:YES];
			[controller release];
			//isModal = TRUE;
		}
		else if(buttonIndex == 1) {
			NSLog(@"OK THEN");
			NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"json"];
			NSString *fileContent2 = [[NSString alloc] initWithContentsOfFile:filePath2];
			NSDictionary *results2 = [fileContent2 JSONValue];
			NSString *credits = [results2 objectForKey:@"credits"];
			NSLog(credits);
			TextViewController *controller = [[TextViewController alloc] initWithContent:credits];
			
			
			
			//UINavigationController *newNavController = [[UINavigationController alloc]
			//											initWithRootViewController:controller];
			//newNavController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			
			//newNavController.modalTransitionStyle =   UIModalTransitionStyleCoverVertical;
			//[self presentModalViewController:newNavController animated:YES];
			//[[self navigationController] presentModalViewController:newNavController animated:YES];
			[self.navigationController pushViewController:controller animated:YES];
			
			[controller release];
			//isModal = YES;	
		}
		else if(buttonIndex == 2) {
			NSLog(@"OK THEN2");
			OfficeViewController *controller = [[OfficeViewController alloc] initWithNibName:@"OfficeViewController" bundle:nil];
			//controller.delegate = self;	
			[self.navigationController pushViewController:controller animated:YES];
			
			[controller release];
		}
	}
	else {
		NSString *image = [(MockPhoto *)_centerPhoto  URLForVersion:TTPhotoVersionLarge];
		image = [image substringFromIndex:9];
		if (buttonIndex == 0) {
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			
			[picker setSubject:@"Eddie Opara's work"];
			
			NSString *caption = [(MockPhoto *)_centerPhoto  caption];	
			
			
			
			UIImage *roboPic = [UIImage imageNamed:image];
			NSData *imageData = UIImageJPEGRepresentation(roboPic, 1);
			[picker addAttachmentData:imageData mimeType:@"image/jpg" fileName:image];
		
			NSString *emailBody = caption;
			[picker setMessageBody:emailBody isHTML:YES];
			
			[self presentModalViewController:picker animated:YES];
			[picker release];
		}
		else {
			UIImage *imgFile = [UIImage imageNamed:image];
			UIImageWriteToSavedPhotosAlbum(imgFile, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
		}
		
	}
}
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
  //  UIAlertView *alertView = [[UIAlertView alloc] 
//							  initWithTitle:NSLocalizedString(@"Galo!!!",@"Saved image message: title")
//							  message:NSLocalizedString(@"Now, check your \"saved photos\" group at \"photos\" app in your iPhone and select the actions menu > set as wallpaper.",@"Saved image message")
//							  delegate:nil
//							  cancelButtonTitle:NSLocalizedString(@"OK",@"OK Button")
//							  otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
}
@end
