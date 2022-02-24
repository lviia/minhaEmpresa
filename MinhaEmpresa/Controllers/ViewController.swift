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
        
        title = "Minha Empresa"
        
        // criando o button de cadastro
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 30
        button.frame = CGRect(x: 300, y: 750, width: 60, height: 60)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func configTableView() {
        namesTableView.dataSource = self
    }
    
    // button de cadastro
    @objc private func didTapButton() {
        let registerVC = registerViewController()
        let navVC = UINavigationController(rootViewController: registerVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    // segunda view controller
    class registerViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "Cadastro"
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(closeButton))
        }
        // button p fechar a register view
        @objc private func closeButton() {
            dismiss(animated: true, completion: nil)
        }
    }
}

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


