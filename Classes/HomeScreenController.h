#import <Three20/Three20.h>
#import "GridViewController.h"

@interface HomeScreenController : UIViewController {
	UIView *contentView;
	UIImageView *myImage;
	UITextView *frontLabel;
	CGRect textFramePortrait;
	CGRect textFrameLandscape;
	int currentOrientation;
}
@end
