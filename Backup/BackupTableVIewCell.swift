//
//  BackupTableVIewCell.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/25.
//

import UIKit

class BackupTableViewCell: BaseTableViewCell {
    
    
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.backgroundColor = .systemGray6
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.addSubview(titleLabel)
        
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.topMargin.equalTo(10)
            make.trailingMargin.equalTo(-10)
            make.bottomMargin.equalTo(-10)
        }
    }
}
