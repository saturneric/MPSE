//
//  Detail.h
//  MPSE
//
//  Created by Saturneric on 17/1/27.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface DetailViewDelegate : UIViewController

@property (strong ,nonatomic) MSPost *ThisPost;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UIImageView *UserImgine;
@property (weak, nonatomic) IBOutlet UITextView *PostText;
@property (weak, nonatomic) IBOutlet UINavigationBar *TopBar;

@end
