//
//  EditReviewPopUpScreenViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/23.
//

import UIKit

class EditReviewPopUpScreenViewController: UIViewController {

    @IBOutlet weak var popUpScreenView: UIView!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    

    func setUI() {
        popUpScreenView.layer.cornerRadius = 30
        activityCollectionView.layer.cornerRadius = 30
        activityCollectionView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
    }

    @IBAction func onClickedXBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

extension EditReviewPopUpScreenViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCollectionViewCell", for: indexPath) as? activityCollectionViewCell else {
            return UICollectionViewCell()
        }
        
      cell.setCellUI()
        
      return cell


    }
    
    
}

extension EditReviewPopUpScreenViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewHeight = collectionView.bounds.height
        let viewWidth = collectionView.bounds.width
       
        return CGSize(width: (viewWidth/10)*9, height: viewHeight/6)
    }
}

class activityCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var mapFrameView: UIView!
    
    
    func setCellUI() {
        self.contentView.layer.cornerRadius = 10
        mapFrameView.layer.cornerRadius = 10
    }
    
}
