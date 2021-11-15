//
//  ViewController.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/09.
//

import UIKit
import KakaoSDKUser
import Alamofire

class LogInBackGroundViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         }

    override func viewDidAppear(_ animated: Bool) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        vcName?.modalPresentationStyle = .overFullScreen
        vcName?.modalPresentationStyle = .overCurrentContext
        self.present(vcName!, animated: true, completion: nil)
        AFGetTourismList()
    }
    
    func AFGetTourismList() {
        let urlStr = "http://3.35.202.118:8080/api/v1/tourism/list/"
        let categoryArr : Array<String> = ["culture","restaurant","street","nature","dullegil"]
        let shared = TouristSpotManager.sharedTouristSpotManager
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            for category in categoryArr {
                let url = URL(string: urlStr+category)!

                let req = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                   
                req.responseJSON { response in
                    switch response.result {
                                case .success:
                                    if let jsonObject = try! response.result.get() as? [String: Any] {
                                    shared.updateData(category: category, dataArr: jsonObject["data"] as! [NSDictionary])
                                    }
                                case .failure(let error):
                                    print(error)
                                    return
                                }
                        }
                }
        }
        }
    
}
