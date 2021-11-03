//
//  SearchCourse.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/15.
//

import Foundation
import UIKit

class RecommendActivityViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var topDesignLayoutView: UIView!
    @IBOutlet weak var imageDescribeView: UIView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var eventView: UIView!
    
    
    let topDesignColor1 = UIColor(named: "Color2")?.cgColor
    let topDesignColor2 = UIColor(named: "Color1")?.cgColor
    
    var images = [#imageLiteral(resourceName: "경춘선숲길.png"),#imageLiteral(resourceName: "노들섬.png")]
    var imageViews = [UIImageView]()
    
    @IBAction func unwindRecommendActivityVC (segue : UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserInfo.shared.name+UserInfo.shared.email)
    }
    
    func setUI() {
        
        imageDescribeView.layer.zPosition = 5
        eventCollectionView.layer.addBorder([.top,.bottom], color: UIColor.systemGray, width: 1.5)
        setPagingScrollView()
    
    }
    func setPagingScrollView() {
        scrollView.delegate = self
              addContentScrollView()
              setPageControl()
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
extension RecommendActivityViewController : UIScrollViewDelegate{
    
    private func addContentScrollView() {
           
           for i in 0..<images.count {
               let imageView = UIImageView()
               let xPos = self.view.frame.width * CGFloat(i)
               imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
               imageView.image = images[i]
               scrollView.addSubview(imageView)
               scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
           }
           
       }
       
       private func setPageControl() {
           pageControl.numberOfPages = images.count
           
       }
       
       private func setPageControlSelectedPage(currentPage:Int) {
           pageControl.currentPage = currentPage
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let value = scrollView.contentOffset.x/scrollView.frame.size.width
           setPageControlSelectedPage(currentPage: Int(round(value)))
       }

}

extension RecommendActivityViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? eventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == 4 {
            cell.setLastBoarder()
        }
        else {
            cell.setUI()
        }
        return cell
    }
    
    
}

extension RecommendActivityViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: eventView.bounds.width, height: eventView.bounds.height*1.2)
    }
    
}

class eventCollectionViewCell : UICollectionViewCell {
    
    func setLastBoarder(){
        self.layer.addBorder([.bottom], color: UIColor.systemGray, width: 1.5)
    }
    
    func setUI() {
        self.layer.addBorder([.bottom], color: UIColor.init(named: "7D7D7D")!, width: 0.5)
    }
}
