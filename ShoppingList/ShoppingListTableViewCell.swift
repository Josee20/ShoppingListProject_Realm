//
//  ShoppingListTableViewCell.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit

protocol ContentsButtonDelegate: AnyObject {
    func checkBoxButtonClickedP(_ sender: UIButton)
    func favoriteButtonClickedP(_ sender: UIButton)
    func moreInfoButtonClickedP(_ sender: UIButton)
}

class ShoppingListTableViewCell: BaseTableViewCell {

    var checkBoxButtonDelegate: ContentsButtonDelegate?
    var favoriteButtonDelegate: ContentsButtonDelegate?
    var moreInfoButtonDelegate: ContentsButtonDelegate?
    
    let checkBoxButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        return view
    }()
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        return view
    }()
    
    let shoppingListTextLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        return view
    }()
    
    let moreInfoButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "info.circle"), for: .normal)
        view.tintColor = .lightGray
        return view
    }()
    
    let shoppingListImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClicked), for: .touchUpInside)
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        self.moreInfoButton.addTarget(self, action: #selector(moreInfoButtonClicked), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: UserShoppingList) {
        
    }
    
    override func configure() {
        [checkBoxButton, favoriteButton, shoppingListTextLabel, moreInfoButton, shoppingListImage].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        checkBoxButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(0)
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            $0.width.equalTo(self.snp.height)
        }
        
        shoppingListImage.snp.makeConstraints {
            $0.leadingMargin.equalTo(checkBoxButton.snp.trailing).offset(10)
            $0.topMargin.equalTo(8)
            $0.bottomMargin.equalTo(-8)
            $0.width.equalTo(32)
        }
        
        shoppingListTextLabel.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.leadingMargin.equalTo(shoppingListImage.snp.trailing).offset(20)
            $0.bottomMargin.equalTo(-10)
            $0.trailingMargin.equalTo(moreInfoButton.snp.leading).offset(-20)
        }
        
        moreInfoButton.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            $0.trailingMargin.equalTo(favoriteButton.snp.leading).offset(10)
            $0.width.equalTo(self.snp.height)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailingMargin.equalTo(0)
            $0.bottomMargin.equalTo(-10)
            $0.topMargin.equalTo(10)
            $0.width.equalTo(self.snp.height)
        }
    }
    
    @objc func checkBoxButtonClicked() {
        checkBoxButtonDelegate?.checkBoxButtonClickedP(checkBoxButton)
    }
    
    @objc func favoriteButtonClicked() {
        favoriteButtonDelegate?.favoriteButtonClickedP(favoriteButton)
    }
    
    @objc func moreInfoButtonClicked() {
        moreInfoButtonDelegate?.moreInfoButtonClickedP(moreInfoButton)
    }
}
