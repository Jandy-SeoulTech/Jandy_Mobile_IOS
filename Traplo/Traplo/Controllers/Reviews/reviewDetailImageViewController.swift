//
//  reviewDetailImageViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/10/03.
//

import UIKit

class reviewDetailImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setUI() {
        imageView.layer.zPosition = 5
    }
    
    @IBAction func onXBtnTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
