//
//  User.h
//  MPSE
//
//  Created by Saturneric on 17/1/26.
//  Copyright © 2017年 Bakantu Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSUserMe : NSObject

@property(nonatomic) NSString *UserID;
@property(nonatomic) NSString *UserName;
@property(strong, nonatomic) UIImage *UserImage;
@property(strong, nonatomic) UIImage *UserPointType;
@property(strong, nonatomic) NSDictionary *UserInfoDetail;
@property(strong, nonatomic) NSString *UserPasswrodHash;

@end

@interface MSLoginMe : NSObject

@property(nonatomic, weak) MSUserMe *targetUser;

- (void)doLogin;
- (void)ifLoginSuccess:(MSUserMe *) userInfo;
- (void)ifLoginFailed:(NSString *)error;

@end

@interface MSRegisterMe : NSObject

- (void)doRegister;
- (void)ifRegisterSuccess;

@end

@interface MSConnectServer : NSObject

@property (nonatomic ,weak) NSString *serverIP;
@property (nonatomic ,weak) NSString *serverPort;
@property (nonatomic, weak) NSString *serverCode;


@end

@interface MSAskForImagine : NSObject

@property(strong,nonatomic)NSString *UserID;
@property(strong,nonatomic)MSConnectServer *Server;

- (void)GetUserImagine;
- (void)GetUserImagineSuccess:(UIImage *)imagine;
- (void)GetUserImagineFail:(NSString *)error;

@end
