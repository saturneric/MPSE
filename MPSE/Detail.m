//
//  Detail.m
//  MPSE
//
//  Created by Saturneric on 17/1/27.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import "Detail.h"

@interface DetailViewDelegate()

@end

@implementation DetailViewDelegate

@synthesize ThisPost= _ThisPost;
@synthesize UserName = _UserName;
@synthesize Time = _Time;
@synthesize PostText = _PostText;
@synthesize TopBar = _TopBar;

- (void)viewDidLoad{
    [super viewDidLoad];
    [_UserName setText:_ThisPost.Username];
    _Time.text = _ThisPost.Time;
    _PostText.text = [NSString stringWithFormat:@"  %@",_ThisPost.Text];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
