//
//  ViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/09.
//

import UIKit
import KakaoSDKUser

class LogInBackGroundViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         }

    override func viewDidAppear(_ animated: Bool) {
        
        let st = UIStoryboard.init(name: "TouristSpot", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "MapSearchTouristSpotViewController")
        vc.modalPresentationStyle = .overFullScreen
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        vcName?.modalPresentationStyle = .overFullScreen
        vcName?.modalPresentationStyle = .overCurrentContext
        self.present(vcName!, animated: true, completion: nil)
        
    }
    
}
