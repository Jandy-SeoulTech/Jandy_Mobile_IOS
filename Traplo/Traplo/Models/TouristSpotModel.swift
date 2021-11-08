//
//  TouristSpotList.swift
//  Traplo
//
//  Created by 김상현 on 2021/11/08.
//

import Foundation

struct TouristSpotModel {
    
    var address : String
    var category : String
    var homepage : String
    var id : Int
    var name : String
    var operatingTime : String
    var phoneNumber : String
    var thumbnailImage : String
   
    init(address:String,category:String,homepage:String,id:Int,name:String,operatingTime:String,phoneNumber:String,thumbnailImage:String) {
        self.address = address
        self.category = category
        self.homepage = homepage
        self.id = id
        self.name = name
        self.operatingTime = operatingTime
        self.phoneNumber = phoneNumber
        self.thumbnailImage = thumbnailImage
    }
    
}

class TouristSpotManager {
    
}
