//
//  LogInViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/11.
//


import Foundation
import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn
import NaverThirdPartyLogin

import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backGroundBtn: UIButton!
    @IBOutlet weak var btnGoogleLogIn: UIView!
    @IBOutlet weak var googleLabel: UILabel!
    @IBOutlet weak var btnNaverLogIn: UIButton!
    @IBOutlet weak var kakaoSymbol: UIImageView!
    @IBOutlet weak var kakaoLabel: UILabel!
    @IBOutlet weak var btnKakaoLogIn: UIButton!
    
    // 구글
    let signInConfig = GIDConfiguration.init(clientID: "1087611763983-rm0g3b1ensfk4b34hejfjrdoq4gjcqtk.apps.googleusercontent.com")
    
    // 네이버
    let NaverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        setUI()
        //UserApi.shared.logout(completion: {(error) in if let error = error{print(error)}})
        NaverLoginInstance?.resetToken()
    
    }
    
    func setUI(){
        
        backGroundBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        backGroundBtn.layer.cornerRadius = 40
        btnNaverLogIn.layer.cornerRadius = 12
        btnKakaoLogIn.layer.cornerRadius = 12
        btnGoogleLogIn.layer.cornerRadius = 12
        googleLabel.layer.zPosition = 5
        kakaoSymbol.layer.zPosition = 5
        kakaoLabel.layer.zPosition = 5
        
        
       
//            btnKakaoLogIn.layer.borderColor = UIColor.white.cgColor
//            btnKakaoLogIn.layer.borderWidth = 2
//            btnKakaoLogIn.layer.cornerRadius = 20
//
//            btnGoogleLogIn.layer.borderColor = UIColor.white.cgColor
//            btnGoogleLogIn.layer.borderWidth = 2
//            btnGoogleLogIn.layer.cornerRadius = 20
//
//            btnNaverLogIn.layer.borderColor = UIColor.white.cgColor
//            btnNaverLogIn.layer.borderWidth = 2
//            btnNaverLogIn.layer.cornerRadius = 20
        
    }
    
    func logInCompleted()  {
        
        let sb = UIStoryboard(name: "Activity", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "RecommendActivityViewController") as! RecommendActivityViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }

    // 구글로 이용하기 버튼 함수
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }
        guard let user = user else { return }
            
        user.authentication.do { authentication, error in
            guard error == nil else { return }
            guard let authentication = authentication else { return }
            
            guard let authorization = authentication.idToken else {return}
            self.AFRequestByTokenGoogle(authorization: authorization)
            
            }
        }
    }
   
    // 카카오로 이용하기 버튼 함수
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
        
        // 토큰 확인
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        // 로그인 필요
                        self.requestKakaoLogin()
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    AuthApi.shared.refreshAccessToken(completion: {(oauthToken,error) in
                        if let error = error{
                            print(error)
                        }
                        else {
                            guard let accessToken = oauthToken?.accessToken else {return}
                            let authorization = "\(accessToken)"
                            
                            self.AFRequestByToken(authorization: authorization,com: "oauthKakao")
                        }
                    })
                }
            }
        }
        else {
            //로그인 필요
            requestKakaoLogin()
        }
    }
    func requestKakaoLogin(){
        // 카카오톡 설치 여부 확인
           if (UserApi.isKakaoTalkLoginAvailable()) {
           // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
               UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
               if let error = error {
                       print(error)
                 }
                   else {
                       guard let accessToken = oauthToken?.accessToken else {return}
                       let authorization = "\(accessToken)"
                       
                       self.AFRequestByToken(authorization: authorization,com: "oauthKakao")
                   }
               }
               }else {UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                   if let error = error {
                       print(error)
                   }
                   else {
                       guard let accessToken = oauthToken?.accessToken else {return}
                       let authorization = "\(accessToken)"

                       self.AFRequestByToken(authorization: authorization,com: "oauthKakao")
                   }
               }
        }
    }

    // 네이버로 이용하기 버튼 함수
    @IBAction func onNaverLoginByAppTouched(_ sender: Any) {
      NaverLoginInstance?.delegate = self
      NaverLoginInstance?.requestThirdPartyLogin()
    }
    
    private func getNaverInfo() {
      guard let isValidAccessToken = NaverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        
        return
      }
        guard let accessToken = NaverLoginInstance?.accessToken else { return }

        let authorization = "\(accessToken)"
        AFRequestByToken(authorization: authorization,com: "oauthNaver")
        
    }
    
    // 카카오,네이버 서버 통신
    func AFRequestByToken(authorization:String,com:String){
        
        let urlStr = "http://3.35.202.118:8080/api/v1/members/"+com
        let url = URL(string: urlStr)!

        let req = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": authorization])
               
        req.responseJSON { response in
            switch response.result {
                        case .success:
                            if let jsonObject = try! response.result.get() as? [String: Any] {
                                let email = jsonObject["email"] as? String
                                let id = jsonObject["id"] as? Int
                                let name = jsonObject["name"] as? String
                                let profileImage = jsonObject["profileImage"] as? String
                              
                                let userInfo = UserInfo.shared
                                userInfo.update(userId: id!, name: name! , profileImage: profileImage!, email: email!)
                                
                            }
                            self.logInCompleted()
                        case .failure(let error):
                            print(error)
                            return
                        }
            }
    }
    
    // 구글 토큰 서버 통신
    func AFRequestByTokenGoogle(authorization:String){
        let urlStr = "http://3.35.202.118:8080/api/v1/members/google"
        let url = URL(string: urlStr)!

        let req = AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": authorization])
               
        req.responseJSON { response in
           
            switch response.result {
                        case .success:
                            if let jsonObject = try! response.result.get() as? [String: Any] {
                                let email = jsonObject["email"] as? String
                                let id = jsonObject["id"] as? Int
                                let name = jsonObject["name"] as? String
                                let profileImage = jsonObject["profileImage"] as? String
                              
                                let userInfo = UserInfo.shared
                                userInfo.update(userId: id!, name: name! , profileImage: profileImage!, email: email!)
                                
                            }
                            self.logInCompleted()
                        case .failure(let error):
                            print(error)
                            return
                        }
            }
    }
}

// 네이버 아이디 로그인 설정
extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    NaverLoginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
    
}
