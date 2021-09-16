//
//  SearchCourse.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/15.
//

import Foundation
import UIKit

class RecommendActivityViewController : UIViewController {
    
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    
    // var gradientLayer: CAGradientLayer!
    
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // layout
//        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
//        // 상단 그라데이션 디자인
//        self.gradientLayer = CAGradientLayer()
//        self.gradientLayer.frame = topDesignView.bounds
//        self.gradientLayer.colors = [topDesignColor1 as Any,topDesignColor2 as Any]
//        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        self.topDesignView.layer.addSublayer(self.gradientLayer)
//
//        self.topDesignView.bringSubviewToFront(topDesignLayoutView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserInfo.shared.name+UserInfo.shared.email)
    }
    
    @IBAction func onMenuBtnTouched(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchCourseUnderBoxViewController")
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func presentReviews(_ sender: Any) {
        let sb = UIStoryboard(name: "Reviews", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EditReviewViewController")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func present기록하기(_ sender: Any) {
        
    }
    
}
