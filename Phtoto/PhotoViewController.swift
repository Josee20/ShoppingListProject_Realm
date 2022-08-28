//
//  PhotoViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/25.
//

import UIKit

class PhotoViewController: BaseViewController {
    
    let mainView = PhotoView()
    
    var selectImage: UIImage?
    var selectIndexPath: IndexPath?
    
    var delegate: SelectImageDelegate?
    
    var photoInfoList: [PhotoInfo] = []
    var currentPage = 1
    var totalPages = 1000
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPhotos()
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.searchBar.delegate = self
        mainView.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = selectButton
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        
        guard let selectImage = selectImage else {
            showAlertMessage(title: "사진을 선택해주세요", button: "확인")
            return
        }
        
        delegate?.sendImageData(image: selectImage)
        dismiss(animated: true)
    }
    
    func showPhotos() {
        UnsplashAPIManager.shared.requestPhotoData(type: .photo, page: currentPage) { json in
            
            for urls in json.arrayValue {

                let photo = urls["urls"]["regular"].stringValue
                let title = urls["user"]["name"].stringValue

                let photoInfo = PhotoInfo(title: title, link: photo)
                self.photoInfoList.append(photoInfo)

            }
            
            self.mainView.collectionView.reloadData()
        }
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.borderWidth = selectIndexPath == indexPath ? 2 : 0
        cell.layer.borderColor = selectIndexPath == indexPath ? UIColor.blue.cgColor : nil
        
        cell.setImage(data: photoInfoList[indexPath.item].link)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else { return }
        
        selectImage = cell.photoView.image
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectIndexPath = nil
        selectImage = nil
        
        collectionView.reloadData()
    }
    
}

extension PhotoViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if photoInfoList.count - 1 == indexPath.item && currentPage < totalPages {
                currentPage += 1
                showPhotos()
            }
        }
    }
}

extension PhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
