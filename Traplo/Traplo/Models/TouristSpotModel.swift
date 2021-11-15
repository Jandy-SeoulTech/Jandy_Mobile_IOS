//
//  TouristSpotList.swift
//  Traplo
//
//  Created by 김상현 on 2021/11/08.
//

import Foundation
import Alamofire

struct TouristSpotModel{
    
    var id : Int
    var name : String
    
    var address : String?
    var category : String?
    var homepage : String?
    var operatingTime : String?
    var phoneNumber : String?
    
    var imageName : String?
    var description : String?
    var rating : Int?
    var ragtingNumber: Int?
   
    init(id:Int,name:String,description:String?,rating:Int?,ratingNumber:Int?,imageName:String?,address:String?,category:String?,homepage:String?,operatingTime:String?,phoneNumber:String?){
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.ragtingNumber = ratingNumber
        self.imageName = imageName
        self.address = address
        self.category = category
        self.homepage = homepage
        self.operatingTime = operatingTime
        self.phoneNumber = phoneNumber
    }
    
    static func updateModel(dic1:NSDictionary,dic2:NSDictionary)->TouristSpotModel{
                
        return TouristSpotModel.init(id: dic1["id"]as! Int, name: dic1["name"] as! String, description: dic1["description"] as? String, rating: dic1["rating"] as? Int, ratingNumber: dic1["ratingNumber"] as? Int, imageName: dic1["imageName"] as? String, address: dic2["address"] as? String, category: dic2["category"] as? String, homepage: dic2["homepage"] as? String, operatingTime: dic2["operatingTime"] as? String, phoneNumber: dic2["phoneNumber"] as? String)
    }
    
   
    //TouristSpotModel.init(id: dic["id"]as! Int, name: dic["name"] as! String, address: dic["address"] as? String, category: dic["category"] as? String, homepage: dic["homepage"] as? String, operatingTime: dic["operatingTime"] as? String, phoneNumber: dic["phoneNumber"] as? String)
    func searchData(searchTerm:String)->Bool{
        if name.contains(searchTerm) || ((address?.contains(searchTerm)) == true){
            return true
        }
        return false
    }
}

class TouristSpotManager {
    
    static let sharedTouristSpotManager = TouristSpotManager()
    
    var touristSpotModelDic : [String:[TouristSpotModel]] = ["culture":[],"restaurant":[],"street":[],"nature":[],"dullegil":[]]

    func updateData (category:String,dataArr:[NSDictionary]) {
       // touristSpotModelDic?.updateValue(data, forKey: category)
        for data in dataArr {
            AF(id: data["id"] as! Int)
            //let q = TouristSpotModel.updateModel(dic1: data,dic2: )
            //touristSpotModelDic[category]?.append(q)
        }
        
    }
    
    func AF(id:Int)->NSDictionary{
        let urlStr = "http://3.35.202.118:8080/api/v1/tourism/"
        let queue = DispatchQueue.global(qos: .userInteractive)
        var returnVal : NSDictionary = [:]
        
            let url = URL(string: urlStr+String(id))!
            let req = Alamofire.AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
              req.responseJSON { response in
                    switch response.result {
                                case .success:
                                    returnVal = try! response.result.get() as? NSDictionary ?? [:]
                                    print(1)
                                   return
                                    
                                case .failure(let error):
                                    print(error)
                                    return
                                }
                    
                }
        
        print(returnVal)
        print(2)
        return returnVal
        
    }
    
    
    func searchData (category:String?,searchTerm:String) -> [Int] {
        
        var returnArr : [Int] = []
        // category 유무 확인
        guard let str = category else {
            // 없을때
            for modelArray in touristSpotModelDic.values{
                for dic in modelArray{
                    if dic.searchData(searchTerm: searchTerm) == true {
                        returnArr.append(dic.id)
                    }
                }
            }
            return returnArr
        }
        // 있을때
        for dic in touristSpotModelDic[str]!{
            if dic.searchData(searchTerm: searchTerm) == true {
                returnArr.append(dic.id)
            }
        }
        return returnArr
    }
}
