//
//  AppDelegate.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/24.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCIMUserInfoDataSource{

    var window: UIWindow?


    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        
        let user = Database.getuser(userId)
        userInfo.userId=userId;
        userInfo.name=user._Username;
        userInfo.portraitUri=user._Pic;
        print(user._Pic)
        return completion(userInfo)
    }
    

    
    func connectIMServer(completion:()->Void,user_info:User)
    {
        
        RCIM.sharedRCIM().initWithAppKey("pkfcgjstffr88")
        RCIM.sharedRCIM().connectWithToken(user_info._Usertoken,
            success: { (userId) -> Void in print(userId)
        let currentUserInfo=RCUserInfo(userId:user_info._Usrid,name:user_info._Username,portrait: user_info._Pic)
            RCIMClient.sharedRCIMClient().currentUserInfo=currentUserInfo
            completion()
            //print("连接成功2")
            },
            error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })

        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        RCIM.sharedRCIM().userInfoDataSource=self

        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

