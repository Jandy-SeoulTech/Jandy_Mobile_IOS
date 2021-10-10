//
//  listSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit
import Cosmos

// 관광지 검색한 후 -list 페이지
class ListSearchTouristSpotViewController: UIViewController {
    
    let keyWordArray = ["   관광명소   ","   숙박   ","   음식점   ","   카페   ","   지하철역   ","   문화시설   ","   대형마트   ","   편의점   ","   학교   ","   공공기관   ","   병원   ","   약국   "]
    let dic = ["   관광명소   ":"AT4", "   숙박   ":"AD5",
               "   음식점   ":"FD6", "   카페   ":"CE7",
               "   지하철역   ":"SW8", "   문화시설   ":"CT1",
               "   대형마트   ":"MT1", "   편의점   ":"CS2",
               "   학교   ":"SC4", "   공공기관   ":"PO3",
               "   병원   ":"HP8", "   약국   ":"PM9"]
/*
     AT4    관광명소
     AD5    숙박
     FD6    음식점
     CE7    카페
     SW8    지하철역
     CT1    문화시설
    MT1    대형마트
    CS2    편의점
    SC4    학교
    PO3    공공기관
    HP8    병원
    PM9    약국
*/
    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    
    @IBOutlet weak var 검색창맵있는뷰: UIView!
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var keyWordCollectionView: UICollectionView!
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

    }
    
    // Btn 영역
    @IBAction func onToggleBtnClicked(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapSearchTouristSpotViewController")
//        vc?.modalPresentationStyle = .overFullScreen
//        self.present(vc!, animated: false, completion: nil)
        dismiss(animated: false, completion: nil)
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
        검색창맵있는뷰.setBorderShadow(borderWidth: 0, cornerRadius: 0, useShadowEffect: true, shadowRadius: 3.0)
       
        setTopDesign()
    }
    // 상단 디자인
    func setTopDesign() {
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = topDesignView.bounds
        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.topDesignView.layer.addSublayer(self.gradientLayer)

        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
    }
}

extension ListSearchTouristSpotViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(keyWordCollectionView){
            return keyWordArray.count
        }else {
        return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.isEqual(keyWordCollectionView){
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchKeyWord", for: indexPath) as? searchKeyWordCollectionViewCell else {
            return UICollectionViewCell()}
      
        cell.setUI(title: keyWordArray[indexPath.row])
        
        return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tourSpotContent", for: indexPath) as? tourSpotContentCollectionViewCell else {
                return UICollectionViewCell()}
            
            cell.setUI()
            
            return cell
        }
    }

}

extension ListSearchTouristSpotViewController:UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            // 키워드 셀 설정
            if collectionView.isEqual(keyWordCollectionView){
            //width 세팅에 사용됨
            let maxSize = CGSize(width: 250, height: 250)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //width
            let collectionViewCellWidth = NSString(string: keyWordArray[indexPath.row]).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 13)], context: nil)
            //height
            let collectionViewCellHeight = collectionView.bounds.height
            return CGSize(width: collectionViewCellWidth.width, height: collectionViewCellHeight)
            }
            // 메인 셀 설정
            else {
                let width = collectionView.bounds.width
                let height = collectionView.bounds.height
                return CGSize(width: width, height: height/6)
            }
        }
    
}

class tourSpotContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowBorderView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    
    func setUI(){
        // 테스트용 내용. 설정 필요!
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

//extension 영역

// 그림자 효과
extension UIView {
    func setBorderShadow(borderWidth : CGFloat,cornerRadius : CGFloat,borderColor : CGColor = UIColor.systemGray.cgColor, useShadowEffect boolean : Bool, shadowRadius : CGFloat){
        
        //테두리 설정
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        
        
        //테두리 그림자 효과 설정
        self.layer.masksToBounds = !boolean
        self.layer.shadowColor = UIColor.systemGray.cgColor // 그림자 색
        self.layer.shadowOffset = CGSize(width: 3, height: 3) // 그림자를 이동시키는 정도
        self.layer.shadowOpacity = 0.7 //그림자 투명도
        self.layer.shadowRadius = shadowRadius //그림자 경계의 선명도 숫자가 클수록 그림자가 많이 퍼진다.
    }
}

// layer -> 특정 부분만 선 추가
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
