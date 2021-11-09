//
//  TouristSpotList.swift
//  Traplo
//
//  Created by 김상현 on 2021/11/08.
//

import Foundation

struct TouristSpotModel{
    
    var id : Int
    var name : String
    var address : String?
    var category : String?
    var homepage : String?
    var operatingTime : String?
    var phoneNumber : String?
    var thumbnailImage : String?
   
    init(id:Int,name:String,address:String?,category:String?,homepage:String?,operatingTime:String?,phoneNumber:String?,thumbnailImage:String?) {
        self.id = id
        self.name = name
        self.address = address
        self.category = category
        self.homepage = homepage
        self.operatingTime = operatingTime
        self.phoneNumber = phoneNumber
        self.thumbnailImage = thumbnailImage
    }
    
    func updateModel(dic:NSDictionary)->Self?{
        return TouristSpotModel.init(id: dic["id"]as! Int, name: dic["name"] as! String, address: dic["address"] as? String, category: dic["category"] as? String, homepage: dic["homepage"] as? String, operatingTime: dic["operatingTime"] as? String, phoneNumber: dic["phoneNumber"] as? String, thumbnailImage: dic["thumbnailImage"] as? String )
    }
    
    func searchData(searchTerm:String)->Bool{
        if name.contains(searchTerm) || ((address?.contains(searchTerm)) == true) || ((homepage?.contains(searchTerm)) == true) || ((category?.contains(searchTerm)) == true){
            return true
        }
        return false
    }
       
    
}

class TouristSpotManager {
    
    static let sharedTouristSpotManager = TouristSpotManager()
    
    var touristSpotModelDic : [String:[TouristSpotModel]] = ["culture":[],"restaurant":[],"street":[],"nature":[],"dullegil":[]]
    
    func updateData (category:String,data:TouristSpotModel) {
       // touristSpotModelDic?.updateValue(data, forKey: category)
        touristSpotModelDic[category]?.append(data)
    }
    
    func searchData (category:String?,searchTerm:String) -> [Int]? {
        
        var returnArr : [Int]?
        
        // category 유무 확인
        guard let str = category else {
            // 없을때
            for modelArray in touristSpotModelDic.values{
                for dic in modelArray{
                    if dic.searchData(searchTerm: searchTerm) == true {
                        returnArr?.append(dic.id)
                    }
                }
            }
            return returnArr
        }
        // 있을때
        for dic in touristSpotModelDic[str]!{
            if dic.searchData(searchTerm: searchTerm) == true {
                returnArr?.append(dic.id)
            }
        }
        return returnArr
    }
}
