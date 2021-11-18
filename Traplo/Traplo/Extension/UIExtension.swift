//
//  extension.swift
//  Traplo
//
//  Created by 김상현 on 2021/11/18.
//

import Foundation
import UIKit

// 그림자 효과
extension UIView {
    func setBorderShadow(borderWidth : CGFloat,cornerRadius : CGFloat,borderColor : CGColor = UIColor.systemGray.cgColor, useShadowEffect boolean : Bool, shadowRadius : CGFloat){
        
        //테두리 설정
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
        
        
        //테두리 그림자 효과 설정
        self.layer.masksToBounds = !boolean
        self.layer.shadowColor = UIColor.systemGray.cgColor // 그림자 색
        self.layer.shadowOffset = CGSize(width: 3, height: 3) // 그림자를 이동시키는 정도
        self.layer.shadowOpacity = 0.7 //그림자 투명도
        self.layer.shadowRadius = shadowRadius //그림자 경계의 선명도 숫자가 클수록 그림자가 많이 퍼진다.
    }
}

// layer -> 특정 부분만 선 추가
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
//completion: @escaping ()->()
extension UIImageView {
public func imageFromURL(urlString: String, placeholder: UIImage?, completion: @escaping (UIImage?)->()) {
if self.image == nil {
self.image = placeholder
}
URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
if error != nil {
print(error)
return
}
DispatchQueue.main.async(execute: { () -> Void in
let image = UIImage(data: data!)
self.image = image
self.setNeedsLayout()
completion(image)
})
}).resume()
}
}

