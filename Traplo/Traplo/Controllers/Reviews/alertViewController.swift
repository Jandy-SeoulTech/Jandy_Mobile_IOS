//
//  alertViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/15.
//

import UIKit

class alertViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    // unwind segue 목적지 VC에 아래 코드 추가필요.(현재 목적지 VC가 정해지지않음)
    //@IBAction func unwindVC1 (segue : UIStoryboardSegue) {}
    
    //https://medium.com/@kyeahen/ios-unwind-segue-in-swift-e8ff0e7fbbcd

    func setUI(){
        view1.layer.cornerRadius = 12
    }
    
    @IBAction func onBtnTouched(_ sender: Any) {
        
    //performSegue(withIdentifier: “unwindToVC1”, sender: self)
        
    }
    

}
