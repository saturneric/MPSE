//
//  Map.m
//  MPSE
//
//  Created by Saturneric on 17/1/25.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import "Map.h"
#import "Post.h"

@interface MapDelegate(){
    UIImage * UserImagine;
    UIImage * PointImagine;
    NSString * UserID;
    NSString * PostID;
}


@property (weak, nonatomic) IBOutlet MKMapView *MapNear;
@property (strong, nonatomic) MKPointAnnotation<MKAnnotation> *AnnotationPointTarget;
@property (nonatomic) CLLocationCoordinate2D MyLocationNow;

@end

@implementation MapDelegate

@synthesize MapNear = _MapNear;
@synthesize AnnotationPointTarget = _AnnotationPointTarget;
@synthesize MyLocationNow = _MyLocationNow;


-(void)viewDidLoad{
    [super viewDidLoad];
    _MapNear.delegate = self;
    
    _MapNear.scrollEnabled = YES;
    _MapNear.zoomEnabled = YES;
    _MapNear.rotateEnabled = YES;
    
    _MapNear.showsBuildings = YES;
    _MapNear.userTrackingMode = MKUserTrackingModeFollow;
    _MapNear.showsUserLocation = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MapAddAnnotation:) name:@"MapAddTarget" object:nil];
    
    
    _MyLocationNow = CLLocationCoordinate2DMake(39.547,116.2317);
    _MapNear.region = MKCoordinateRegionMake(_MyLocationNow, MKCoordinateSpanMake(0.006, 0.006));
    MKMapCamera *MySeeCamera = [MKMapCamera cameraLookingAtCenterCoordinate:_MyLocationNow fromEyeCoordinate:_MyLocationNow eyeAltitude:20000 ];
    _MapNear.camera = MySeeCamera;
    
    
    PointImagine = [UIImage imageNamed:@"PointType.ico"];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.MyLocationNow = userLocation.coordinate;
    _MapNear.region = MKCoordinateRegionMake(_MyLocationNow, MKCoordinateSpanMake(0.006, 0.006));
    MKMapCamera *MySeeCamera = [MKMapCamera cameraLookingAtCenterCoordinate:_MyLocationNow fromEyeCoordinate:_MyLocationNow eyeAltitude:500 ];
    _MapNear.camera = MySeeCamera;
}

-(void)MapAddAnnotation:(NSNotification *) Notification{
    NSArray *SharePost = Notification.object;
    self.AnnotationPointTarget = [[MKPointAnnotation alloc] init];
    
    [_AnnotationPointTarget setTitle: [SharePost objectAtIndex:0]];
    if ([[SharePost objectAtIndex:1] length] >25){
        [_AnnotationPointTarget setSubtitle:[SharePost objectAtIndex:1]];
    }
    else{
        [_AnnotationPointTarget setSubtitle:[SharePost objectAtIndex:1]];
    }
    UserImagine = [SharePost objectAtIndex:2];
    _AnnotationPointTarget.coordinate = _MyLocationNow;
    [_MapNear addAnnotation:_AnnotationPointTarget];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    if([annotation isKindOfClass:[MKPointAnnotation class]]){
        MKAnnotationView *DefineView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ShareBy"];
        if(!DefineView){
            DefineView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ShareBy"];
            [DefineView setImage:PointImagine];
            DefineView.canShowCallout = YES;
            
            UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            
            UIImage *TargetUserImagine = UserImagine;
            UIImageView *TargetImagineView = [[UIImageView alloc] initWithImage:TargetUserImagine];
            [TargetImagineView setFrame:CGRectMake(0, 0, 50, 50)];
            
            UIButton *DetailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            DetailButton.frame = CGRectMake(0, 0, 50, 50);
            DetailButton.backgroundColor = [UIColor clearColor];
            [DetailButton setTitle:@"详情" forState:UIControlStateNormal];
            
            NSArray *ThisAnnotationDetail = [[NSArray alloc] initWithObjects:annotation,TargetImagineView, nil];
            
            
            [DetailButton addTarget:self action: @selector(DetailButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            TargetImagineView.contentMode = UIViewContentModeScaleToFill;
            [LeftView addSubview:TargetImagineView];
            [DefineView setLeftCalloutAccessoryView:LeftView];
            [DefineView setRightCalloutAccessoryView:DetailButton];
            [DefineView setDetailCalloutAccessoryView:DetailButton];
            DefineView.canShowCallout = YES;
        }
        return DefineView;
    }
    return nil;
}

- (void)DetailButtonOnClick:(UIButton *) button{
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
