//
//  mapSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit

// 관광지 검색한 후 -map 페이지
class MapSearchTouristSpotViewController: UIViewController {

    let keyWordArray = ["  관광명소  ","  숙박  ","  음식점  ","  카페  ","  지하철역  ","  문화시설  ","  대형마트  ","  편의점  ","  학교  ","  공공기관  ","  병원  ","  약국  "]
    let dic = ["  관광명소  ":"AT4", "  숙박  ":"AD5",
               "  음식점  ":"FD6", "  카페  ":"CE7",
               "  지하철역  ":"SW8", "  문화시설  ":"CT1",
               "  대형마트  ":"MT1", "  편의점  ":"CS2",
               "  학교  ":"SC4", "  공공기관  ":"PO3",
               "  병원  ":"HP8", "  약국  ":"PM9"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

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
    
    
    
    func setUI() {
       
        검색창리스트버튼있는뷰.setBorderShadow(borderWidth: 0, cornerRadius: 0, useShadowEffect: true, shadowRadius: 3.5)

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
            let collectionViewCellWidth = NSString(string: keyWordArray[indexPath.row]).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil)
            //height
            let collectionViewCellHeight = collectionView.bounds.height
            return CGSize(width: collectionViewCellWidth.width, height: collectionViewCellHeight)
        }
    
}

class searchKeyWordCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var keyword: UIButton!
    
    func setUI(title : String){
        keyword.layer.cornerRadius = 12.5
        keyword.setTitle(title, for: UIControl.State.normal)
    }

}
