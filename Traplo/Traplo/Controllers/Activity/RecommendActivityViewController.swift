//
//  SearchCourse.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/15.
//

import Foundation
import UIKit
import Alamofire

class RecommendActivityViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var imageDescribeView: UIView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventView: UIView!
    
    //color
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    let queue = DispatchQueue.main
    
    //event
    var numOfEvent : Int = -1
    var eventData : [NSDictionary] = []
    
    //image
    var images = [#imageLiteral(resourceName: "경춘선숲길.png"),#imageLiteral(resourceName: "노들섬.png")]
    var imageViews = [UIImageView]()
    
    @IBAction func unwindRecommendActivityVC (segue : UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AFGetEventList()
        setUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserInfo.shared.name+UserInfo.shared.email)
    }
    
    func setUI() {
        
        imageDescribeView.layer.zPosition = 5
        eventCollectionView.layer.addBorder([.top,.bottom], color: UIColor.systemGray, width: 1.5)
        setPagingScrollView()
    
    }
    func setPagingScrollView() {
        scrollView.delegate = self
              addContentScrollView()
              setPageControl()
    }
    
    func AFGetEventList() {
        let urlStr = "http://3.35.202.118:8080/api/v1/events"
        let url = URL(string: urlStr)!

        let req = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
               
        req.responseJSON { response in
            switch response.result {
                        case .success:
                            if let jsonObject = try! response.result.get() as? [String: Any] {
                                
                                self.numOfEvent = jsonObject["count"] as! Int
                                self.eventData = jsonObject["data"] as! [NSDictionary]
                
                                DispatchQueue.main.async {

                                self.eventCollectionView.reloadData() }
                               
                            }
                        case .failure(let error):
                            print(error)
                            return
                        }
            
            }
    }
    
    @IBAction func presentReviews(_ sender: Any) {
        let sb = UIStoryboard(name: "Reviews", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EditReviewViewController")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func presentTouristSpot(_ sender: Any) {
        
        let st = UIStoryboard.init(name: "TouristSpot", bundle: nil)
           let vc = st.instantiateViewController(withIdentifier: "MapSearchTouristSpotViewController")
           vc.modalPresentationStyle = .overFullScreen
           vc.modalPresentationStyle = .overCurrentContext
           self.present(vc, animated: true, completion: nil)
           
    }
    
}
extension RecommendActivityViewController : UIScrollViewDelegate{
    
    private func addContentScrollView() {
           
           for i in 0..<images.count {
               let imageView = UIImageView()
               let xPos = self.view.frame.width * CGFloat(i)
               imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
               imageView.image = images[i]
               scrollView.addSubview(imageView)
               scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
           }
           
       }
       
       private func setPageControl() {
           pageControl.numberOfPages = images.count
           
       }
       
       private func setPageControlSelectedPage(currentPage:Int) {
           pageControl.currentPage = currentPage
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let value = scrollView.contentOffset.x/scrollView.frame.size.width
           setPageControlSelectedPage(currentPage: Int(round(value)))
       }

}

extension RecommendActivityViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            if self.numOfEvent>5 {
                self.numOfEvent = 5
                }
            if self.numOfEvent == -1{
                return 0
            }
        return numOfEvent
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? eventCollectionViewCell else {
                return UICollectionViewCell()
            }
            
                cell.setUI(index: indexPath.item, numOfEvent: self.numOfEvent, eventData: self.eventData[indexPath.item])

       
        return cell
        
    }
    
}

extension RecommendActivityViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: eventView.bounds.width, height: eventView.bounds.height*1.2)
    }
    
}

class eventCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventHost: UILabel!
    @IBOutlet weak var eventContinue: UIImageView!
    
    
    func setLastBoarder(){
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 1.5)
    }
    
    func setBoarder(){
        
        self.layer.addBorder([.bottom], color: UIColor.init(named: "7D7D7D")!, width: 0.5)
    }
    func setData(data : NSDictionary){
      
        let applicationStartDate : String = data["applicationStartDate"] as! String
        let applicationEndDate :String = data["applicationEndDate"] as! String
        let name : String = data["name"] as! String
        let host : String = data["host"] as! String
        
        eventDate.text =
        applicationEndDate + "~" + applicationStartDate
        
        eventHost.text = "| "+host
        
        eventName.text = name
        
        if isExpired(startDate: applicationEndDate, endDate: applicationStartDate) == true {
            eventContinue.image = UIImage.init(named: "진행중")
        }
        
    }
    func setUI(index : Int, numOfEvent : Int, eventData : NSDictionary) {
        if index == (numOfEvent-1) {
            setLastBoarder()
        }
        else {
            setBoarder()
        }
        setData(data: eventData)
        
    }
    
    func isExpired(startDate:String,endDate:String)->Bool{
        var isep : Bool = false
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        guard let startDate = dateFormatter.date(from: startDate)else{return false}
        guard let endDate = dateFormatter.date(from: endDate)else {return false}
        guard let currentDate = dateFormatter.date(from: dateFormatter.string(from: Date()))else {return false}

        if startDate <= currentDate && currentDate <= endDate
        {isep = true}

        return isep
       }
}
