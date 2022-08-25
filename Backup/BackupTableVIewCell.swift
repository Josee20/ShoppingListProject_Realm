//
//  BackupTableVIewCell.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/25.
//

import UIKit

class BackupTableViewCell: BaseTableViewCell {
    
    let zipImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    let titleLabel: UILabel = {
       let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.backgroundColor = .systemGray6
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let dateLabel: UILabel = {
       let view = UILabel()
        view.textColor = .white
        view.backgroundColor = .systemGray6
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        
        [zipImageView, titleLabel, dateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        zipImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.equalTo(20)
            make.bottomMargin.equalTo(-20)
            make.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.topMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottomMargin.equalTo(dateLabel.snp.top).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.topMargin.equalTo(10)
            make.trailingMargin.equalTo(-20)
            make.bottomMargin.equalTo(-10)
        }
    }
    
}
