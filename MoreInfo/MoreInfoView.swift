//
//  moreInfoView.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/24.
//

import UIKit
import SnapKit

class MoreInfoView: BaseView {
    
    let shoppingItemImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    let searchImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo.artframe"), for: .normal)
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.backgroundColor = .blue
        view.tintColor = .white
        return view
    }()
    
    let changeShoppingItemButton: UIButton = {
        let view = UIButton()
        view.setTitle("변경", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let shoppingItemTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func configureUI() {
        [shoppingItemImage, searchImageButton, shoppingItemTextField, changeShoppingItemButton].forEach { self.addSubview($0) } 
    }
    
    override func setConstraints() {
        
        shoppingItemImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(self.snp.width)
        }
        
        searchImageButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(safeAreaLayoutGuide).offset(-20)
            make.bottomMargin.equalTo(shoppingItemImage.snp.bottom).offset(-20)
            make.width.height.equalTo(60)
        }
        
        shoppingItemTextField.snp.makeConstraints { make in
            make.trailing.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.topMargin.equalTo(shoppingItemImage.snp.bottom).offset(40)
            make.height.equalTo(60)
        }
        
        changeShoppingItemButton.snp.makeConstraints { make in
            make.topMargin.equalTo(shoppingItemTextField.snp.top).offset(20)
            make.bottomMargin.equalTo(shoppingItemTextField.snp.bottom).offset(-20)
            make.trailingMargin.equalTo(shoppingItemTextField.snp.trailing).offset(-20)
            make.width.equalTo(60)
            
        }
    }
}
