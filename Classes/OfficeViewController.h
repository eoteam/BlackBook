//
//  ScrollingViewController.h
//  Scrolling
//
//  Created by David Janes on 09-09-25.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface OfficeViewController : UIViewController
<UIScrollViewDelegate>
{
	IBOutlet UIScrollView* scrollView;
	IBOutlet UIPageControl* pageControl;
	IBOutlet UIWebView* contentView;
    BOOL pageControlIsChangingPage;
	NSArray *images;
	int currentOrientation;
}
@property (nonatomic, retain) UIWebView *contentView;
@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;

/* for pageControl */
- (IBAction)changePage:(id)sender;

/* internal */
- (void)setupPage;

@end

