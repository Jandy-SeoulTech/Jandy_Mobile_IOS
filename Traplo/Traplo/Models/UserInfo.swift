//
//  UserInfo.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/25.
//

import Foundation

// 현재 로그인한 유저의 정보
class UserInfo {
    // 싱글톤~
    static var shared = UserInfo()
    
    var userId :Int
    var name : String
    var profileImage: String
    var email : String
    
    init(userId:Int = 0,name:String = "이름",profileImage:String = "profileImage",email:String = "email") {
        self.userId = userId
        self.name = name
        self.profileImage = profileImage
        self.email = email
    }
    
    func update(userId:Int ,name:String ,profileImage:String ,email:String) {
        self.userId = userId
        self.name = name
        self.profileImage = profileImage
        self.email = email
    }
    
}
