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
    
    var delegate: SendDataDelegate?
    
    var tag = 0
    let localRealm = try! Realm()
    let mainView = MoreInfoView()
    
    var item: String = ""
    var objectID: ObjectId?
    
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
        
        mainView.changeShoppingItemButton.addTarget(self, action: #selector(changeShoppingItemButtonClicked), for: .touchUpInside)
        mainView.searchImageButton.addTarget(self, action: #selector(searchImageButtonClicked), for: .touchUpInside)
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        let selectButton = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(selectButtonClicked))
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = selectButton
        
    }
    
    @objc func changeShoppingItemButtonClicked() {
        
        delegate?.sendItemValue(item: mainView.shoppingItemTextField.text!, index: tag)
        showAlertMessage(title: "쇼핑리스트가 변경되었습니다")
        self.navigationItem.title = mainView.shoppingItemTextField.text!
        
    }
    
    @objc func searchImageButtonClicked() {
        let vc = PhotoViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        
        // 이미지 이름 objectID(PK)활용해 만들고 이미지 저장
        if let image = mainView.shoppingItemImage.image {
            saveImageToDocument(fileName: "\(objectID!).jpg", image: image)
        }
        
        dismiss(animated: true)
    }  
}

extension MoreInfoViewController: SelectImageDelegate {

    func sendImageData(image: UIImage) {
        mainView.shoppingItemImage.image = image
        print(#function)
    }
}
