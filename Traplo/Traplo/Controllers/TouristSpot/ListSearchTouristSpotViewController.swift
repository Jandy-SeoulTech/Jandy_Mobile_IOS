//
//  listSearchTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit
import Cosmos
import Alamofire

// 관광지 검색한 후 -list 페이지
class ListSearchTouristSpotViewController: UIViewController {
    
    let shared = TouristSpotManager.sharedTouristSpotManager
    let keyWordArray = ["기본순","둘레길","문화 역사","식당","이색거리","자연"]
    let keyWordEngArray = [nil,"dullegil","culture","restaurant","street","nature"]
    var touristSpotArray : [TouristSpotModel] = []

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
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        setSearchBar()
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
    func setSearchBar() {
        
        let hor = -(searchBar.bounds.width / 15)
        
        searchBar.searchTextField.leftViewMode = .never
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffset(horizontal: hor, vertical: 0)
    }
}

extension ListSearchTouristSpotViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(keyWordCollectionView){
            return keyWordArray.count
        }else {
            return touristSpotArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.isEqual(keyWordCollectionView){
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchKeyWord", for: indexPath) as? searchKeyWordCollectionViewCell else {
            return UICollectionViewCell()}
      
            let title = "   "+keyWordArray[indexPath.item]+"   "
            cell.setUI(title: title)
            
            if indexPath.item == 0 {
               cell.isSelected = true
               collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
             }

        return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tourSpotContent", for: indexPath) as? tourSpotContentCollectionViewCell else {
                return UICollectionViewCell()}
            
            let val = touristSpotArray[indexPath.item]
            cell.setUI(name: val.name, rating: val.rating ?? 0 , describe: val.description ?? "" , image: val.imageName ?? "")
            
            return cell
        }
    }

}

extension ListSearchTouristSpotViewController:UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
            // 키워드 셀 설정
            if collectionView.isEqual(keyWordCollectionView){
            let title = "   "+keyWordArray[indexPath.item]+"   "
            //width 세팅에 사용됨
            let maxSize = CGSize(width: 250, height: 250)
            let heightOnFont = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            //width
            let collectionViewCellWidth = NSString(string: title).boundingRect(with: maxSize, options: heightOnFont, attributes: [.font: UIFont.systemFont(ofSize: 13)], context: nil)
            //height
            let collectionViewCellHeight = collectionView.bounds.height
            return CGSize(width: collectionViewCellWidth.width, height: collectionViewCellHeight)
            }
            // 메인 셀 설정
            else {
                let width = collectionView.bounds.width
                let height = collectionView.bounds.height
                return CGSize(width: width, height: round(height/6))
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(keyWordCollectionView){
        guard let searchTerm = searchBar.text else { return }
            touristSpotArray = shared.searchData(category: keyWordEngArray[indexPath.item], searchTerm: searchTerm)
            contentCollectionView.reloadData()
        }
        
    }
    
}

class tourSpotContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowBorderView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    
    func setUI(name: String,rating:Int,describe:String,image:String){
        // 테스트용 내용. 설정 필요!
        titleLabel.text = name
        ratings.rating = Double(rating)
        describeTextView.text = describe
        
        self.clipsToBounds = true
        ratings.settings.updateOnTouch = false
        
        setBorder()
        setImageView(image: image)
        
    }
    func setBorder() {
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 0.3)
    }
    func setImageView(image:String) {
        let urlStr = "http://3.35.202.118:8080/images/"
        let url = URL(string: urlStr+image)!
        imageView.imageFromURL(urlString: urlStr+image, placeholder: imageView.image)
            { image in self.imageView.image = image
        }
        imageView.layer.cornerRadius = 5
    }
}

extension ListSearchTouristSpotViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let category = keyWordEngArray[(keyWordCollectionView.indexPathsForSelectedItems?.first!.item)!]
        touristSpotArray = shared.searchData(category: category , searchTerm: searchTerm)
        contentCollectionView.reloadData()
    }
    
}

