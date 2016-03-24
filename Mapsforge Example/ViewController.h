//
//  ViewController.h
//  Mapsforge Example
//
//  Created by Matthew Hall on 8/28/15.
//  Copyright (c) 2015 Matthew Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IOSMapView.h"

@interface ViewController : UIViewController {
    IOSMapView *mapView;
}

@property (nonatomic,retain) IBOutlet IOSMapView *mapView;

@end

