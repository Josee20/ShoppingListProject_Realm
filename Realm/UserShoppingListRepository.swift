//
//  UserShoppingListRepository.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/28.
//

import Foundation
import UIKit

import RealmSwift


protocol UserShoppingListRepositoryType {
    func fetchFilter(word: String) -> Results<UserShoppingList>
    func fetchDate(date: Date) -> Results<UserShoppingList>
    func updateFavorite(item: UserShoppingList)
    func updateCheckBox(item: UserShoppingList)
    func fetch() -> Results<UserShoppingList>
    func addNewShoppingList(item: Results<UserShoppingList>, new: Object)
    func delete(item: UserShoppingList?)
}

class UserShoppingListRepository: UserShoppingListRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "favorite", ascending: false)
    }
    
    func fetchDate(date: Date) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).filter("diaryDate <= %@ AND diaryDate < %@", date, Date(timeInterval: 86400, since: date))
    }
    
    func fetchFilter(word: String) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).filter("diaryTitle CONTAINS[c] 'a'")
    }
    
    func updateFavorite(item: UserShoppingList) {
        do {
            try localRealm.write {
                item.favorite = !item.favorite
            }
        } catch {
            print("즐겨찾기버튼 오류")
        }
    }
    
    func updateCheckBox(item: UserShoppingList) {
        do {
            try localRealm.write {
                item.checkBox = !item.checkBox
            }
        } catch {
            print("체크박스버튼 오류")
        }
    }
    
    func addNewShoppingList(item: Results<UserShoppingList>, new: Object) {
        
        do {
            try localRealm.write {
                localRealm.add(new)
            }
        } catch {
            print("쇼핑리스트 추가 에러")
        }
    }
    
    func delete(item: UserShoppingList?) {
        do {
            try localRealm.write {
                removeImageToDocument(imageName: "\(item!.objectID).jpg")
                localRealm.delete(item!)
            }
        } catch {
            print("Remove Image error")
        }
    }
    
    func changeItemValue(currentItem: UserShoppingList, newItem: String) {
        do {
            try localRealm.write {
                currentItem.toDo = newItem
            }
        } catch let error {
            print("value send error", error)
        }
    }
    
    
    
    
    
    
    
    func removeImageToDocument(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let error {
            print(error)
        }
    }
    
}
