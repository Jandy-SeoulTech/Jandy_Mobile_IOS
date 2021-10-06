//
//  BookMarkEditViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/05.
//

import UIKit

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
