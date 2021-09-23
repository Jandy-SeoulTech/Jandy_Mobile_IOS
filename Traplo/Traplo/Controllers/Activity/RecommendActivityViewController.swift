//
//  SearchCourse.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/15.
//

import Foundation
import UIKit

class RecommendActivityViewController : UIViewController {
    
    //#imageLiteral(resourceName: "")
    var images = [#imageLiteral(resourceName: "R1280x0")]
    var imageViews = [UIImageView]()
    
    
    @IBOutlet weak var topDesignView: UIView!
    @IBOutlet weak var topDesignLayoutView: UIView!
    
    @IBOutlet weak var pageControlScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        setPageControlScrollView()
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
    
    func setPageControlScrollView(){
        pageControlScrollView.delegate = self
        addContentScrollView()
        setPageControl()
    }
    
    private func addContentScrollView() {
            
            for i in 0..<images.count {
                let imageView = UIImageView()
                let xPos = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPos, y: 0, width: pageControlScrollView.bounds.width, height: pageControlScrollView.bounds.height)
                imageView.image = images[i]
                pageControlScrollView.addSubview(imageView)
                pageControlScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
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
