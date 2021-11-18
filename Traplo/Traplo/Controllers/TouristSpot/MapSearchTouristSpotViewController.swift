//
//  mapSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit
import Alamofire

// 관광지 검색한 후 -map 페이지
class MapSearchTouristSpotViewController: UIViewController {

    let keyWordArray = ["   기본순   ","   둘레길   ","   문화 역사   ","   식당   ","   이색거리   ","   자연   "]
    
    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
   
    //reference
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var keyWordCollectionView: UICollectionView!
    @IBOutlet weak var 검색창리스트버튼있는뷰: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let shared = TouristSpotManager.sharedTouristSpotManager
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

    }
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    // Btn 영역
    @IBAction func onToggleBtnClicked(_ sender: Any) {
        
        // 클릭 시 이동 화면 list search tourist spot view controller 로 설정
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListSearchTouristSpotViewController")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
        
        // 클릭 시 이동 화면 select tourist spot view controller 로 설정
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectTouristSpotViewController")
//        vc?.modalPresentationStyle = .overFullScreen
//        self.present(vc!, animated: false, completion: nil)
    }
  
    @IBAction func btnTraplo(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindRecommendActivityVC", sender: self)
     
    }
    
    @IBAction func btn찜목록(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "BookMarkViewController")
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
        
        
    }
    
    func setUI() {
       
        검색창리스트버튼있는뷰.setBorderShadow(borderWidth: 0, cornerRadius: 0, useShadowEffect: true, shadowRadius: 3.5)
        setSearchBar()
        setTopGradationDesign()
    }
    
    // 상단 그라데이션 디자인
    func setTopGradationDesign() {
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = topDesignView.bounds
        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.topDesignView.layer.addSublayer(self.gradientLayer)

        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
    }
    // 검색창
    func setSearchBar() {
        
        let hor = -(searchBar.bounds.width / 15)
        
        searchBar.searchTextField.leftViewMode = .never
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffset(horizontal: hor, vertical: 0)
    }
}

extension MapSearchTouristSpotViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return keyWordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchKeyWord", for: indexPath) as? searchKeyWordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.setUI(title: keyWordArray[indexPath.row])
        
        return cell
    }

}

extension MapSearchTouristSpotViewController:UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            //width 세팅에 사용됨
            let maxSize = CGSize(width: 250, height: 250)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //width
            let collectionViewCellWidth = NSString(string: keyWordArray[indexPath.row]).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 13)], context: nil)
            //height
            let collectionViewCellHeight = collectionView.bounds.height
            return CGSize(width: collectionViewCellWidth.width, height: collectionViewCellHeight)
        }
    
}

class searchKeyWordCollectionViewCell : UICollectionViewCell {
    
    // UIColor
    let keyWordSelectedBackGroundColor = UIColor(named: "7D7D7D")
    let keyWordSelectedTextColor = UIColor.white
    
    let keyWordDefaultBackGroundColor = UIColor(named: "C4C4C4")
    let keyWordDefaultTextColor = UIColor(named: "515151")
    

    @IBOutlet weak var keywordLabel: UILabel!
    
    func setUI(title : String){
        
        keywordLabel.clipsToBounds = true
        keywordLabel.layer.cornerRadius = 12
        keywordLabel.text = title
    
    }
    
   override var isSelected: Bool {
    didSet {
        if isSelected {
           
            keywordLabel.textColor = keyWordSelectedTextColor
            keywordLabel.backgroundColor = keyWordSelectedBackGroundColor
            
        } else {
            
            keywordLabel.textColor = keyWordDefaultTextColor
            keywordLabel.backgroundColor = keyWordDefaultBackGroundColor

        
      }
    }

}
}
extension MapSearchTouristSpotViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(shared.searchData(category: nil, searchTerm: searchBar.text!))
    }
}
