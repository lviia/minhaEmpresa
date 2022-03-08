//
//  ViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 26/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var namesTableView: UITableView!
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        buttonRegister()
        navBar()
    }
    
    func configTableView() {
        namesTableView.dataSource = self
    }
    
    func navBar() {
        title = "Minha Empresa"
        navigationController?.navigationBar.backgroundColor = .orange
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    // MARK: - Button
    
    func buttonRegister() {
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        // aumentando a fonte
        let label = self.button.titleLabel
        label?.minimumScaleFactor = 0.01
        label?.adjustsFontSizeToFitWidth = true
        label?.font = UIFont.systemFont(ofSize: 30)
        
        // constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    // chamando a VC de cadastro
    @objc private func didTapButton() {
        let registerVC = RegisterViewController()
        // let navVC = UINavigationController(rootViewController: registerVC)
        // navVC.modalPresentationStyle = .fullScreen
        // present(registerVC, animated: true)
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

// MARK: - Table view

// configurando a table view
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Pessoa \(indexPath.row)"
        return cell
    }
}


