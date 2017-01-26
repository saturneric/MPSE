//
//  Post.h
//  MPSE
//
//  Created by Saturneric on 17/1/26.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MSPost : NSObject

@property(nonatomic) NSString *UserID;
@property(nonatomic) NSString *PostID;
@property(nonatomic) NSString *Username;
@property(nonatomic) NSString *Text;
@property(nonatomic) NSString *Time;
@property(nonatomic) CLLocationCoordinate2D *Location;

@end
