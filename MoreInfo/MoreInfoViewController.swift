//
//  MoreInfoViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/24.
//

import UIKit
import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class MoreInfoViewController: BaseViewController {
    
    let localRealm = try! Realm()
    let mainView = MoreInfoView()
    
    var item: String = ""
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = item
        view.backgroundColor = .white
        
        configure()
        
    }
    
    override func configure() {
        mainView.searchImageButton.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        let selectButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(selectButtonClicked))
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = selectButton
    }
    
    @objc func searchImageButtonClicked() {
        let vc = PhotoViewController()
        
        // 왜들어가는거지?...
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        
        let toDoList = UserShoppingList(checkBox: false, toDo: "굿샷", favorite: false)
        
        do {
            try localRealm.write {
                localRealm.add(toDoList)
            }
        } catch let error {
            print(error)
        }
        
        // 이미지 이름 objectID(PK)활용해 만들고 이미지 저장
        if let image = mainView.shoppingItemImage.image {
            saveImageToDocument(fileName: "\(toDoList.objectID).jpg", image: image)
        }
        
        dismiss(animated: true)
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}

extension MoreInfoViewController: SelectImageDelegate {
    
    func sendImageData(image: UIImage) {
        mainView.shoppingItemImage.image = image
        print(#function)
    }
}
