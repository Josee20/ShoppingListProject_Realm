//
//  BackupViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/25.
//

import Foundation
import UIKit
import RealmSwift
import Zip

class BackupViewController: BaseViewController {
    
    let mainView = BackupView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(BackupTableViewCell.self, forCellReuseIdentifier: "cell")
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = closeButton
        
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func showActivitiyViewController() {
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlertMessage(title: "백업 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_1")
            print("Archive Location : \(zipFilePath)")
            showActivitiyViewController()
        } catch {
            showAlertMessage(title: "압축을 실패했습니다")
        }
        
    }
    
    @objc func restoreButtonClicked() {
        
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true)
    }
    
    
    
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BackupTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            showAlertMessage(title: "선택하신 파일에 오류가 있습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("ShoppingList_1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")}, fileOutputHandler: { unzippedFile in
                        print("unzippedFile: \(unzippedFile)")
                        self.showAlertMessage(title: "복구가 완료되었습니다.")
                    })
            } catch let error {
                print(error.localizedDescription)
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
        } else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("ShoppingList_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    
                }, fileOutputHandler: { unzippedFile in
                    self.showAlertMessage(title: "복구가 완료되었습니다.")
                })
                
            } catch let error {
                print(error.localizedDescription)
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
        }
    }
}
