//
//  ViewController.swift
//  ShoppingListProject_Realm
//
//  Created by 이동기 on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = ShoppingListViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }


}

