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
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var 삭제Btn: UIButton!
    @IBOutlet weak var 완료Btn: UIButton!
    
    
    
    var selectedArray = Array(repeating: false, count: 15)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
       
        setTopGradationDesign()
        setMidView()
        setBottomView()
        
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
   
   
    // 중단 뷰 테두리 설정
    func setMidView(){
        midView.layer.addBorder([.bottom], color: UIColor.darkGray, width: 0.3)
    }
    
    func setBottomView(){
        bottomView.layer.addBorder([.top], color: UIColor.darkGray, width: 0.3)
        완료Btn.layer.cornerRadius = 10
        삭제Btn.layer.cornerRadius = 10
    }

    @IBAction func onDeleteBtnTouched(_ sender: Any) {
        
    }
    
}

extension BookMarkEditViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkEditContent", for: indexPath) as? BookMarkEditContentCollectionViewCell else {
            return UICollectionViewCell()}
        
        cell.setUI(isSelect: selectedArray[indexPath.item])
        
        
        return cell
        
    }
}

extension BookMarkEditViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedArray[indexPath.item].toggle()
        
        collectionView.reloadData()
        
    }

}

extension BookMarkEditViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height
        return CGSize(width: width, height: round(height/6.5))
        }
}




class BookMarkEditContentCollectionViewCell:UICollectionViewCell{
    
    var isSelect : Bool = false
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var describeTextView: UITextView!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var cellSupplementaryView: UIView!
    
    func setUI(isSelect:Bool){
        // 테스트용 내용. 설정 필요!
        titleLabel.text = "dd"
        ratings.rating = 3
        describeTextView.text = "ddddddkdkdkdkdkdkdkdkkddkkddkkdkdkdkdkdkdkdkdkdkdkdkdkdkdk"
        cellSupplementaryView.isUserInteractionEnabled = false
        setBorder()
        setImageView()
        
       selectionEvent(isSelect: isSelect)
    }
    func setBorder() {
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 0.3)
    }
    func setImageView() {
        imageView.layer.cornerRadius = 5
    }
    func selectionEvent(isSelect:Bool){
        if isSelect == true {
            self.checkMark.image = UIImage.init(systemName: "checkmark.circle.fill")
        }else {
            self.checkMark.image = UIImage.init(systemName: "circle")
        }
    }
  
}
