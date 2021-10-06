//
//  BookMarkEditViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/05.
//

import UIKit
import Cosmos

class BookMarkEditViewController: UIViewController {

    //gradient
    var gradientLayer: CAGradientLayer!
    
    //UIColor
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    //reference
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
       
        setTopGradationDesign()
        setEditBtnBorder()
        setMidView()
        
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

}








extension BookMarkEditViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkEditContent", for: indexPath) as? BookMarkEditContentCollectionViewCell else {
            return UICollectionViewCell()}
        
        cell.setUI()
        
        return cell
        
    }
    
    
}

extension BookMarkEditViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height/7)
        }
    
}

class BookMarkEditContentCollectionViewCell:UICollectionViewCell{
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    
    func setUI(){
        // 테스트용 내용. 설정 필요!
        titleLabel.text = "dd"
        ratings.rating = 3
        describeTextView.text = "d"
        
        setBorder()
        
    }
    func setBorder() {
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 0.3)
    }
   
}
