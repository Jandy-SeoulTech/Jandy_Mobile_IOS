//
//  SelectTouristSpotViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/28.
//

import UIKit
import Cosmos

// 관광지 선택 페이지
class SelectTouristSpotViewController: UIViewController {
    @IBOutlet weak var titleLabelView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var reviewPicView: UIView!
    @IBOutlet weak var ratingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI() {
        titleLabelView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        contentView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        reviewPicView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        ratingView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        
    }
   
}
