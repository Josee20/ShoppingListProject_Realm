//
//  URL+Extension.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/27.
//

import Foundation

extension URL {
    static let photoURL = "https://api.unsplash.com/photos/"

    static func makePhotoEndPointString(_ endPoint: String) -> String {
        return photoURL + endPoint
    }
}
