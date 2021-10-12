//
//  BookMarkViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/05.
//

import UIKit
import Cosmos

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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
    
    
}






extension BookMarkViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookMarkContent", for: indexPath) as? BookMarkContentCollectionViewCell else {
            return UICollectionViewCell()}
        
        cell.setUI()
        
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
