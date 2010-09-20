//
//  MyAnnotation.m
//  cDactGPS
//
//  Created by Gozu on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation
@synthesize coordinate, title, subtitle;

-(id) initWithCoordinate: (CLLocationCoordinate2D) _coordinate{
	if((self = [super init])){
		coordinate = _coordinate;
	}
	return self;
}

-(void) dealloc{
	[title release];
	[subtitle release];
	[super dealloc];
}
@end
