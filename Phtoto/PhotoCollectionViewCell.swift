//
//  PhotoTableViewCell.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/25.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    let photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.addSubview(photoView)
    }
    
    override func setConstraints() {
        photoView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setImage(data: String) {
        let url = URL(string: data)
        photoView.kf.setImage(with: url)
    }
    
}
