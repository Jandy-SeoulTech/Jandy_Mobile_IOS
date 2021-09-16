//
//  PloggingRecord.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/25.
//

import Foundation

struct PloggingRecordModel : Equatable{
    
    var modelId : Int // model 아이디
    var ownerId : Int // 기록 작성자
    
    var date:date // 기록일
    var distance:Float // 거리
    var time:Float // 걸린 시간
    var start:String // 시작 위치
    var end:String // 종료 위치
    
    mutating func update(date:date,distance:Float,time:Float,start:String,end:String) {
        
        self.date = date
        self.distance = distance
        self.time = time
        self.start = start
        self.end = end
    }
    
    // Equatable 로 '==' 연산자 임의로 정의.
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.modelId == rhs.modelId
    }
    
}

struct date {
    
    let year:Int
    let month:Int
    let day:Int
    
    init(year:Int,month:Int,day:Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    var date: String{
        return "\(year)+.+\(month)+.+\(day)"
    }
    
}

// 여러개 존재하는 PloggingRecordModel 객체를 관리합니다.
class PloggingRecordModelManager {
    
    // 싱글톤~~
    static let shared = PloggingRecordModelManager()
    
    // 기록 아이디번호(modelId) 선언에 사용할 정수값
    static var ploggingRecordModelLastId: Int = 0
    
    func createPloggingRecordModel(date:date,distance:Float,time:Float,start:String,end:String)->PloggingRecordModel{
        
        let nextId = Self.ploggingRecordModelLastId + 1
        Self.ploggingRecordModelLastId = nextId
        
        let ownerId = UserInfo.shared.userId
        
        return PloggingRecordModel(modelId: nextId, ownerId: ownerId, date: date, distance: distance, time: time, start: start, end: end)
   
    }
    
}
