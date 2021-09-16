//
//  AppDelegate.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/09.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import NaverThirdPartyLogin
import GoogleMaps


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // init 카카오로그인
        KakaoSDKCommon.initSDK(appKey: "93a0755257e0b57cf8ed85ffff2e5ba2")
        
        setNaverLogin()
        // Google Maps
        GMSServices.provideAPIKey("AIzaSyD9l1nhuI-8iEzG_69Q66ltr2Ao7EJPBU4")
        
        return true
    }
    // 네이버 로그인
    func setNaverLogin(){
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
            
            // 네이버 앱으로 인증하는 방식을 활성화
            instance?.isNaverAppOauthEnable = true
            
            // SafariViewController에서 인증하는 방식을 활성화
            instance?.isInAppOauthEnable = true
            
            // 인증 화면을 iPhone의 세로 모드에서만 사용하기
            instance?.isOnlyPortraitSupportedInIphone()
        
            // 애플리케이션을 등록할 때 입력한 URL Scheme
            instance?.serviceUrlScheme = kServiceAppUrlScheme
            // 애플리케이션 등록 후 발급받은 클라이언트 아이디
            instance?.consumerKey = kConsumerKey
            // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
            instance?.consumerSecret = kConsumerSecret
            // 애플리케이션 이름
            instance?.appName = kServiceAppName
    }
    
    //구글 로그인
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }else {
      // Handle other custom URL types.
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }else{
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        }
        return true
      }
      // If not handled by this app, return false.
      return false
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
  

}


