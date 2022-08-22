//
//  ShoppingListTableViewCell.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    let checkBoxButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.tintColor = .black
        return view
    }()
    
    let shoppingListTextLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [checkBoxButton, favoriteButton, shoppingListTextLabel].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
        
        checkBoxButton.snp.makeConstraints {
            $0.leadingMargin.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            $0.width.equalTo(self.snp.height)

        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailingMargin.bottomMargin.equalTo(-10)
            $0.topMargin.equalTo(10)
            $0.width.equalTo(self.snp.height)
        }
        
        shoppingListTextLabel.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.leadingMargin.equalTo(checkBoxButton.snp.trailing).offset(20)
            $0.bottomMargin.equalTo(-10)
            $0.trailingMargin.equalTo(favoriteButton.snp.leading).offset(-20)
        }
    }
    
}
