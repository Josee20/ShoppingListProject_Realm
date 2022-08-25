//
//  ShoppingListViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit
import RealmSwift
import SnapKit

class ShoppingListViewController: BaseViewController {
    
    let localRealm = try! Realm()
    
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
        
        print(localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        
        toDoList = localRealm.objects(UserShoppingList.self)
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
    }
    
    @objc func backupButtonClicked() {
        let vc = BackupViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func addButtonClicked() {
        let toDo = UserShoppingList(checkBox: false, toDo: mainView.shoppingTextField.text!, favorite: false)
        
        try! localRealm.write {
            localRealm.add(toDo)
        }
        
        mainView.shoppingTextField.text = ""
        
        tableView.reloadData()
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  ShoppingListTableViewCell

        cell.backgroundColor = .systemGray6
        
        cell.setData(data: toDoList[indexPath.row])
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
            let item = toDoList?[indexPath.row]
            try! localRealm.write {
                localRealm.delete(item!)
            }
            tableView.reloadData()
           
        } 
    }
}

extension ShoppingListViewController: ContentsButtonDelegate {
    
    func checkBoxButtonClickedP(_ sender: UIButton) {
        try! self.localRealm.write {
            toDoList[sender.tag].checkBox = !toDoList[sender.tag].checkBox
        }

        tableView.reloadData()
    }
    
    func favoriteButtonClickedP(_ sender: UIButton) {
        try! self.localRealm.write {
            toDoList[sender.tag].favorite = !toDoList[sender.tag].favorite
        }
        
        tableView.reloadData()
    }
    
    func moreInfoButtonClickedP(_ sender: UIButton) {
        let vc = MoreInfoViewController()
        vc.item = toDoList[sender.tag].toDo
        let nav = UINavigationController(rootViewController: vc)
        
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

