#import "MapViewController.h"
#import "MyAnnotation.h"

@implementation MapViewController

@synthesize mapView;

-(void)viewDidLoad
{
    [super viewDidLoad];
	[self reverseGeocodeCurrentLocation];
	self.title = @"New York Office";
    mapView.showsUserLocation = NO;
}

- (void)viewDidUnload
{
    self.mapView = nil;
}

- (void)dealloc
{
    [mapView release];
    [super dealloc];
}

- (void)reverseGeocodeCurrentLocation
{
	CLLocationCoordinate2D coord;
	coord.latitude = 40.74303f;
	coord.longitude = -73.988686f;
	
    MKCoordinateRegion region;
    region.center = coord;
    MKCoordinateSpan span = {0.005, 0.005};
    region.span = span;
    [mapView setRegion:region animated:YES];
	officePin = [[[MyAnnotation alloc] initWithCoordinate:coord] autorelease];
	officePin.title = @"Pentagram";
	officePin.subtitle = @"204 Fifth Avenue New York NY 10010";
	[mapView addAnnotation: officePin];
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)theMapView
{
	[mapView selectAnnotation:officePin animated:FALSE];
}
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[mapView selectAnnotation:officePin animated:FALSE];
}
#pragma mark -
#pragma mark MKMapViewDelegate
	 

	 
	 - (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
	{
		// if it's the user location, just return nil.
		if ([annotation isKindOfClass:[MKUserLocation class]])
			return nil;
		
		// handle our two custom annotations
		//
		if ([annotation isKindOfClass:[MyAnnotation class]]) // for Golden Gate Bridge
		{
			// try to dequeue an existing pin view first
			static NSString* OfficeAnnotationIdentifier = @"officeAnnotationIdentifier";
			MKPinAnnotationView* pinView = (MKPinAnnotationView *)
			[mapView dequeueReusableAnnotationViewWithIdentifier:OfficeAnnotationIdentifier];
			if (!pinView)
			{
				// if an existing pin view was not available, create one
				MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
													   initWithAnnotation:annotation reuseIdentifier:OfficeAnnotationIdentifier] autorelease];
				customPinView.pinColor = MKPinAnnotationColorRed;
				customPinView.animatesDrop = YES;
				customPinView.canShowCallout = YES;
				customPinView.selected = YES;
				return customPinView;
			}
			else
			{
				pinView.annotation = annotation;
			}
			return pinView;
		}
		
		
		return nil;
	}
	 
@end
