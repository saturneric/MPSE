//
//  ViewController.m
//  MPSE
//
//  Created by Saturneric on 17/1/25.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *ShareText;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (strong, nonatomic) CLLocation *ShareLocationNow;

@property (strong,nonatomic) CLLocationManager *Location;

@end

@implementation ViewController

@synthesize ShareButton = _ShareButton;
@synthesize ShareText = _ShareText;
@synthesize Location = _Location;
@synthesize ShareLocationNow = _ShareLocationNow;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[_ShareButton titleLabel] setText:@"分享"];
    _ShareText.text = @"你所在的位置有没有什么新鲜事?";
    _LocationLabel.text = @"";
    _ShareText.delegate = self;
    
    _Location = [[CLLocationManager alloc]init];
    _Location.delegate = self;
    _Location.desiredAccuracy = kCLLocationAccuracyBest;
    
    [_Location requestWhenInUseAuthorization];
    
    [_Location startUpdatingLocation];
    
    [self.view endEditing:YES];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    _ShareText.text = @"";
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *LocationNow = [locations lastObject];
    CLGeocoder *GeocoderNow = [[CLGeocoder alloc] init];
    [GeocoderNow reverseGeocodeLocation:LocationNow completionHandler:^(NSArray *array, NSError *error){
        if(array.count > 0){
            CLPlacemark *PlacemarkNow = [array objectAtIndex:0];
            NSDictionary *Address = PlacemarkNow.addressDictionary;
            NSString *LableDisplay = [[NSString alloc] initWithFormat:@"%@, %@",[Address valueForKey:@"Name"],[Address valueForKey:@"Country"]];
            [_LocationLabel setText: LableDisplay];
            self.ShareLocationNow = LocationNow;
            
        }
     }];
}

- (IBAction)ShareClick:(id)sender {
    NSString *ShareTextNow = _ShareText.text;
    NSString *Username = @"Me";
    UIImage *UserImagine = [UIImage imageNamed:@"Me.png"];
    
    NSUUID *PostID = [[NSUUID alloc] init];
    
    
    NSArray *SharePost = [[NSArray alloc] initWithObjects:Username,ShareTextNow,UserImagine,nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MapAddTarget" object:SharePost];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
