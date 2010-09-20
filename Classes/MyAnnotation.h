//
//  MyAnnotation.h
//  cDactGPS
//
//  Created by Gozu on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString * subtitle;
	NSString * title;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (retain) NSString * subtitle;
@property (retain) NSString * title;
-(id) initWithCoordinate: (CLLocationCoordinate2D) _coordinate;
@end
