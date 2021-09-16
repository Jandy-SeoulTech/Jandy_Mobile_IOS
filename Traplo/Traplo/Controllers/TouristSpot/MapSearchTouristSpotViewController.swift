//
//  mapSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit

// 관광지 검색한 후 -map 페이지
class MapSearchTouristSpotViewController: UIViewController {

    let array = ["  문화 역사  ","  이색거리  ","  식당  ","  자연  ","  둘레길  "]
    
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
    
    @IBAction func onToggleBtnClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListSearchTouristSpotViewController")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: false, completion: nil)
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
     
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchKeyWord", for: indexPath) as? searchKeyWordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.setUI(title: array[indexPath.row])
        
        return cell
    }

}

extension MapSearchTouristSpotViewController:UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            //width 세팅에 사용됨
            let maxSize = CGSize(width: 250, height: 250)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //width
            let collectionViewCellWidth = NSString(string: array[indexPath.row]).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil)
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
