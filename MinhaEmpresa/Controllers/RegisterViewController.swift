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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 11.0, *) {
            navigationItem.backButtonTitle = "Voltar"
        } else {
            navigationItem.backBarButtonItem?.title = "Voltar"
        }
    }
}
