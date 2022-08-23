//
//  ShoppingListView.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit
import SnapKit


class ShoppingListView: UIView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "쇼핑"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        return view
    }()
    
    let shoppingTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실 건가요?"
        view.textAlignment = .left
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.setTitle("추가", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 5
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [titleLabel, textFieldBackgroundView, shoppingTextField, addButton].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(20)
            $0.centerX.equalTo(UIScreen.main.bounds.width / 2)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        
        textFieldBackgroundView.snp.makeConstraints {
            $0.topMargin.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leadingMargin.equalTo(12)
            $0.trailingMargin.equalTo(-12)
            $0.height.equalTo(60)
        }
        
        shoppingTextField.snp.makeConstraints {
            $0.topMargin.equalTo(textFieldBackgroundView.snp.top).offset(20)
            $0.leadingMargin.equalTo(textFieldBackgroundView.snp.leading).offset(20)
            $0.bottomMargin.equalTo(textFieldBackgroundView.snp.bottom).offset(-20)
            $0.trailingMargin.equalTo(addButton.snp.leading).offset(-20)
        }
        
        addButton.snp.makeConstraints {
            $0.topMargin.equalTo(textFieldBackgroundView.snp.top).offset(20)
            $0.trailingMargin.equalTo(textFieldBackgroundView.snp.trailing).offset(-20)
            $0.bottomMargin.equalTo(textFieldBackgroundView.snp.bottom).offset(-20)
            $0.width.equalTo(50)
        }
    }
    
    
}
