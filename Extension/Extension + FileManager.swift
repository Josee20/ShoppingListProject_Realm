//
//  Extension.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/26.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Document 디렉토리 URL 가져오기
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory
    }
    
    // 이미지 불러오기
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil} //Document 경로
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부 경로. 이미지 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    // 이미지 저장하기
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileURL = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    // 이미지 삭제하기
    func removeImageToDocument(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch let error {
            print(error)
        }
    }
    
    // 백업파일 목록 나타내기
    func fetchDocumentZipFile() -> [String?] {
        
        var zipFileList = [String]()
        
        do {
            guard let path = documentDirectoryPath() else { return [nil] }
            
            // 도큐먼트의 컨텐츠가 전부 다나옴
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            print("docs: \(docs)")
            
            // pathExtension은 확장자를 뜻함
            let zip = docs.filter { $0.pathExtension == "zip" }
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            zipFileList.append(contentsOf: result)
            print("result \(result)")
            
        } catch {
            print("Error")
        }
        
        return zipFileList
    }
}
