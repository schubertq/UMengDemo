//
//  ViewController.m
//  UMengDemo
//
//  Created by schubert on 2017/2/7.
//  Copyright © 2017年 schubertq. All rights reserved.
//

#import "ViewController.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>

@interface ViewController ()

@end

@implementation ViewController
// SSO package or sign error
- (IBAction)sinaLogin {
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}

- (IBAction)qqLogin {
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

- (IBAction)wexinLogin {
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

// 微信第三方登录拿到数据全部为null
// errcode = 41004;
// errmsg = "appsecret missing, hints: [ req_id: c2ybZa0163ssz3 ]";
// 分享不需要secret，第三方登录需要

// 新浪微博
// sso package or sign error：Bundle ID  或者是修改目前运行程序的bundle ID
// redirecturi 不匹配
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            
            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.gender);
            
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (IBAction)share:(id)sender {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
//        [self shareImageAndTextToPlatformType:platformType];
//        [self shareTextToPlatformType:platformType];
        [self shareImageToPlatformType:platformType];
    }];
}

//[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]'
//[self configUSharePlatforms]; 未打开
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"default"];
    [shareObject setShareImage:@"https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=775dcd3bc195d143ce7bec711299e967/d62a6059252dd42a1dce20930a3b5bb5c8eab8c6.jpg"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"default"];
    [shareObject setShareImage:@"https://imgsa.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=775dcd3bc195d143ce7bec711299e967/d62a6059252dd42a1dce20930a3b5bb5c8eab8c6.jpg"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        } else {
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
