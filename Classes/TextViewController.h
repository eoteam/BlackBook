//
//  TextViewController.h
//  Pentagram
//
//  Created by raed on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TextViewController : UIViewController  {
	NSString* content;
	UITextView *textView;
}
@property (copy) NSString *content;

-(id)initWithContent:(NSString *)content;
@end
