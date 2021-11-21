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
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabelView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var reviewPicView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var operatingTimeLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var modelImageCollectionView: UICollectionView!
    
    var model : TouristSpotModel?
    var modelImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        setUI()
        setModel()
    }
    
    func setUI() {
        titleLabelView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        contentView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        reviewPicView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        ratingView.layer.addBorder([.bottom], color: UIColor.systemGray3, width: 0.3)
        
    }
    func setModel() {
        titleLabel.text = model?.name
        addressLabel.text = model?.address
        operatingTimeLabel.text = model?.operatingTime
        phoneNumberLabel.text = model?.phoneNumber
        websiteLabel.text = model?.homepage
        contentImageView.image = modelImage
        cosmosView.rating = Double(model?.rating ?? 0)
        cosmosView.settings.updateOnTouch = false
    }
    @IBAction func onClickedBackward(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SelectTouristSpotViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(modelImageCollectionView){
            return 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "modelImageCollectionViewCell", for: indexPath) as? modelImageCollectionViewCell
        else {return UICollectionViewCell()}
        cell.setUI(image: modelImage)
        
        return cell
        
    }
    
    
}

extension SelectTouristSpotViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(modelImageCollectionView){
        let height = collectionView.bounds.height*0.9
        let CGSize = CGSize(width: height, height: height)
        return CGSize
        }
        return CGSize(width: 10, height: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(modelImageCollectionView) {
            let sb = UIStoryboard(name: "Reviews", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "reviewDetailImageViewController") as? reviewDetailImageViewController else { print(1)
                return }
            vc.modelImage = self.modelImage
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false, completion: nil)
            
        }
    }
}

class modelImageCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var modelImage: UIImageView!
    
    func setUI(image : UIImage?) {
    modelImage.image = image
        self.layer.addBorder([.all], color: UIColor.black, width: 1)
        self.backgroundColor = UIColor.systemGray6
        self.layer.cornerRadius = 8
    }
}
