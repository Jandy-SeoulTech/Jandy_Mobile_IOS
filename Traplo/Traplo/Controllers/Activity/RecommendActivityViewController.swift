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
    
    @IBOutlet weak var imageDescribeView: UIView!
    
    
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserInfo.shared.name+UserInfo.shared.email)
    }
    
    func setUI() {
        imageDescribeView.layer.zPosition = 5
    
    }
    
    @IBAction func presentReviews(_ sender: Any) {
        let sb = UIStoryboard(name: "Reviews", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EditReviewViewController")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func presentTouristSpot(_ sender: Any) {
        
        let st = UIStoryboard.init(name: "TouristSpot", bundle: nil)
           let vc = st.instantiateViewController(withIdentifier: "MapSearchTouristSpotViewController")
           vc.modalPresentationStyle = .overFullScreen
           vc.modalPresentationStyle = .overCurrentContext
           self.present(vc, animated: true, completion: nil)
           
    }
    
}
