//
//  BookMarkViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/05.
//

import UIKit
import Cosmos
import Alamofire

class BookMarkViewController: UIViewController {

    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    //reference
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var numLabel: NSLayoutConstraint!
    
    var wishList : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        afGetList()
    }
    
    func setUI() {
       
        setTopDesign()
        setEditBtnBorder()
        setMidView()
        
    }
    
    // 상단 디자인 설정
    func setTopDesign() {
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = topDesignView.bounds
        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.topDesignView.layer.addSublayer(self.gradientLayer)

        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
        
        editBtn.layer.zPosition = 5

    }
    
    // 편집 버튼 테두리 설정
    func setEditBtnBorder() {
        editBtn.layer.borderWidth = 0.3
        editBtn.layer.borderColor = UIColor.systemGray.cgColor
        editBtn.layer.cornerRadius = 8
    }
   
    // 중단 뷰 테두리 설정
    func setMidView(){
        midView.layer.addBorder([.bottom], color: UIColor.darkGray, width: 0.3)
    }
    
    
    // Btn 영역
    @IBAction func editBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "BookMarkEditViewController")
        vc?.modalPresentationStyle = .overFullScreen
        present(vc!, animated: false, completion: nil)
    
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func afGetList() {
        let shared = UserInfo.shared
        print(shared.userId)
        let urlStr = "http://3.35.202.118:8080/api/v1/wishlist/" + String(shared.userId)
        let url = URL(string: urlStr)!
        
        let req = Alamofire.AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        
        
        req.responseJSON{ response in
            switch response.result {
            
                                case .success:
                                if let jsonObject = try! response.result.get() as? NSDictionary  {
                                    let count = jsonObject["count"] as! Int
                                    let q = jsonObject["data"] as! [NSDictionary]
                                    for a in 1...count {
                                        let tourismDic = q[a]["tourism"] as! NSDictionary
                                        let id = tourismDic["id"]as!Int
                                        self.wishList.append(id)
                                    }
                                    return}
                                                            
                                    return
                                    
                                case .failure(let error):
                                    print(error)
                                    return
                                }
       }
    }
    
}


extension BookMarkViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkContent", for: indexPath) as? BookMarkContentCollectionViewCell else {
            return UICollectionViewCell()}
        
        cell.setUI(id : wishList[indexPath.item])
        
        return cell
        
    }
    
    
}
extension BookMarkViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
        return CGSize(width: width, height: round(height/6.5))
        }
    
}

class BookMarkContentCollectionViewCell:UICollectionViewCell{
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    
    func setUI(id:Int){
        // 테스트용 내용. 설정 필요!
        print(id)
        titleLabel.text = "dd"
        ratings.rating = 3
        describeTextView.text = "ddddd"
        
        setBorder()
        setImageView()
        
    }
    func setBorder() {
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 0.3)
    }
    func setImageView() {
        imageView.layer.cornerRadius = 5
    }
   
}
