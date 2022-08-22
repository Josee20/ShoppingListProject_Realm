//
//  ShoppingListViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit
import RealmSwift
import SnapKit

class ShoppingListViewController: UIViewController {
    
    let localRealm = try! Realm()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let checkBoxButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        return view
    }()
    
    // var toDoList: [UserShoppingList] = []
    // class도 자료형으로 사용이 가능한가?
    var toDoList: Results<UserShoppingList>!
    
    
    let mainView = ShoppingListView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-20)
            make.leadingMargin.equalTo(20)
            make.bottomMargin.equalTo(-20)
            make.topMargin.equalTo(mainView.textFieldBackgroundView.snp.bottom).offset(20) 
        }
        
        toDoList = localRealm.objects(UserShoppingList.self)
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        print(localRealm.configuration.fileURL)
    }
    
    @objc func addButtonClicked() {
        let toDo = UserShoppingList(checkBox: false, toDo: mainView.shoppingTextField.text!, favorite: false)
        
        try! localRealm.write {
            localRealm.add(toDo)
        }
        
        mainView.shoppingTextField.text = ""
        
        tableView.reloadData()
    }

    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = toDoList[indexPath.row].toDo
        cell.backgroundColor = .systemGray6
        
        [checkBoxButton, favoriteButton].forEach { self.tableView.addSubview($0) }
        
//        checkBoxButton.snp.makeConstraints { make in
//            make.topMargin.equalTo(10)
//            make.leadingMargin.equalTo(0)
//            make.bottomMargin.equalTo(-10)
//            make.width.equalTo(30)
//        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            toDoList[indexPath.row].
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}


