#import <Three20/Three20.h>
#import "JSON.h"  
#import "BaseGridViewController.h"

@interface GridViewController :BaseGridViewController  <UIAlertViewDelegate>{
	
	UIToolbar *toolbar;
	NSMutableArray  *images;         // Titles of images
	BOOL *isModal;
}

@end
