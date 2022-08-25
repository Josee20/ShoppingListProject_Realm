//
//  Extension.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/26.
//

import Foundation
import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory
    }
    
}
