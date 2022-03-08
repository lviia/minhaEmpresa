//
//  TesteViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 04/03/22.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cadastro"
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem?.title = ""
    }
}
