//
//  reviewDetailImageViewController.swift
//  Traplo
//
//  Created by κΉμν on 2021/10/03.
//

import UIKit

class reviewDetailImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var modelImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI() {
        imageView.layer.zPosition = 5
        imageView.image = modelImage
    }
    
    @IBAction func onXBtnTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
