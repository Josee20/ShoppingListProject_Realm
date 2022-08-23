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
}

class ShoppingListTableViewCell: UITableViewCell {

    var checkBoxButtonDelegate: ContentsButtonDelegate?
    var favoriteButtonDelegate: ContentsButtonDelegate?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClicked), for: .touchUpInside)
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [checkBoxButton, favoriteButton, shoppingListTextLabel].forEach { contentView.addSubview($0) }
    }
    
    func setConstraints() {
        
        checkBoxButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(0)
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            $0.width.equalTo(self.snp.height)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailingMargin.equalTo(0)
            $0.bottomMargin.equalTo(-10)
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
    
    @objc func checkBoxButtonClicked() {
        checkBoxButtonDelegate?.checkBoxButtonClickedP(checkBoxButton)
//        checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
        
    }
    @objc func favoriteButtonClicked() {
        favoriteButtonDelegate?.favoriteButtonClickedP(favoriteButton)
//        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
}
