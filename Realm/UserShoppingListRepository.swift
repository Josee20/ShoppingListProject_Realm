//
//  UserShoppingListRepository.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/28.
//

import Foundation
import RealmSwift

protocol UserShoppingListRepositoryType {
    func fetchFilter(word: String) -> Results<UserShoppingList>
}

//class UserShoppingListRepository: UserShoppingListRepositoryType {
    
//    func fetchFilter(word: String) -> Results<UserShoppingList> {
//        return localRealm.objects(UserShoppingList.self).filter("diaryTitle CONTAINS[c] 'a'")
//    }
//}
