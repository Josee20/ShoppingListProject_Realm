//
//  ShoppingListViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit
import RealmSwift
import SnapKit

protocol SendDataDelegate {
    func sendItemValue(item: String, index: Int)
}

class ShoppingListViewController: BaseViewController {
    
    let repository = UserShoppingListRepository()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 5
        
        return view
    }()

    let mainView = ShoppingListView()
    
    var toDoList: Results<UserShoppingList>! {
        
        didSet {
            tableView.reloadData()
            print("tasks Changed")
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-20)
            make.leadingMargin.equalTo(20)
            make.bottomMargin.equalTo(-20)
            make.topMargin.equalTo(mainView.textFieldBackgroundView.snp.bottom).offset(20) 
        }
        
        print(repository.localRealm.configuration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRealm()
        tableView.reloadData()
    }
    
    override func configure() {
        
        toDoList = repository.localRealm.objects(UserShoppingList.self)
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
    }
    
    func fetchRealm() {
        toDoList = repository.fetch()
    }
    
    
    @objc func backupButtonClicked() {
        let vc = BackupViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func addButtonClicked() {
        let toDo = UserShoppingList(checkBox: false, toDo: mainView.shoppingTextField.text!, favorite: false)
        
        repository.addNewShoppingList(item: self.toDoList, new: toDo)
        
        mainView.shoppingTextField.text = ""
        
        tableView.reloadData()
    }
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  ShoppingListTableViewCell

        cell.backgroundColor = .systemGray6
        
        // 쇼핑리스트 이미지
        cell.shoppingListImage.image = loadImageFromDocument(fileName: "\(toDoList[indexPath.row].objectID).jpg")
        
        //레이블
        cell.shoppingListTextLabel.text = toDoList[indexPath.row].toDo
        
        //상세정보
        cell.moreInfoButtonDelegate = self
        cell.moreInfoButton.tag = indexPath.row
        
        //체크박스
        cell.checkBoxButtonDelegate = self
        cell.checkBoxButton.tag = indexPath.row
        let checkBoxButtonImage = toDoList[indexPath.row].checkBox ? "checkmark.square.fill" : "checkmark.square"
        cell.checkBoxButton.setImage(UIImage(systemName: checkBoxButtonImage), for: .normal)
        
        //즐겨찾기
        cell.favoriteButtonDelegate = self
        cell.favoriteButton.tag = indexPath.row
        let favoriteButtonImage = toDoList[indexPath.row].favorite ? "star.fill" : "star"
        cell.favoriteButton.setImage(UIImage(systemName: favoriteButtonImage), for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            repository.delete(item: toDoList?[indexPath.row])
            
            tableView.reloadData()
        } 
    }
}

// 체크박스 버튼, 즐겨찾기 버튼, info버튼 델리게이트
extension ShoppingListViewController: ContentsButtonDelegate {
    
    func checkBoxButtonClickedP(_ sender: UIButton) {
        self.repository.updateCheckBox(item: self.toDoList[sender.tag])
        tableView.reloadData()
    }
    
    func favoriteButtonClickedP(_ sender: UIButton) {
        
        self.repository.updateFavorite(item: self.toDoList[sender.tag])
        
        // 즐겨찾기 버튼 클릭시 위로 이동
        fetchRealm()
        
        tableView.reloadData()
    }
    
    func moreInfoButtonClickedP(_ sender: UIButton) {
        let vc = MoreInfoViewController()
        vc.tag = sender.tag
        vc.objectID = toDoList[sender.tag].objectID
        vc.item = toDoList[sender.tag].toDo
        
        // SendDataDelegate(아이템 바꿀 때)
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

// 쇼핑리스트 아이템 수정 델리게이트
extension ShoppingListViewController: SendDataDelegate {
    func sendItemValue(item: String, index: Int) {
        
        repository.changeItemValue(currentItem: toDoList[index], newItem: item)
        
//        do {
//            try repository.localRealm.write {
//                toDoList[index].toDo = item
//            }
//        } catch let error {
//            print("value send error", error)
//        }
        
    }
}

