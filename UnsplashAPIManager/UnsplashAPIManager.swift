//
//  UnsplashAPIManager.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/27.
//

import Foundation

import Alamofire
import SwiftyJSON

class UnsplashAPIManager {
    
    private init() { }
    
    static let shared = UnsplashAPIManager()
    
    func requestPhotoData(type: EndPoint, page: Int, completionHandler: @escaping (JSON) -> () ) {

        let url = "\(type.requestURL)?client_id=\(APIKey.unsplashKey)&page=\(page)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
