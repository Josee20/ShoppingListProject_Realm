//
//  RealmModel.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import RealmSwift

class UserShoppingList: Object {
    @Persisted var checkBox: Bool // 체크박스
    @Persisted var toDo: String   // 투두리스트
    @Persisted var favorite: Bool // 즐겨찾기
    
    // PK설정(필수)
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(checkBox: Bool, toDo: String, favorite: Bool) {
        self.init()
        self.checkBox = checkBox
        self.toDo = toDo
        self.favorite = favorite
    }
    
}
