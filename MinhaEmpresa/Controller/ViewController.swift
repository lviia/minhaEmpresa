//
//  ViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 26/01/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        buttonNavController()
        navBar()
    }
    
    // MARK: - Navbar
    func navBar() {
        title = "Minha Empresa"
        navigationController?.navigationBar.backgroundColor = .orange
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Button
    let button = UIButton()
    
    func buttonNavController() {
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
        let registerVC = CadastroViewController()
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(registerVC, animated: true)
        
        if #available(iOS 11.0, *) {
            navigationItem.backButtonTitle = "Voltar"
        } else {
            navigationItem.backBarButtonItem?.title = "Voltar"
        }
    }
}

// MARK: - Table View
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        nomesTableView.dataSource = self
        nomesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


