//  ViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 26/01/22.
//

import UIKit
import CoreData

protocol AtualizarFuncionariosDelegate {
    func buscarFuncionario()
    func adicionar(funcionario: FuncionarioInput)
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomesTableView: UITableView!
    
    // Reference managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Funcionario]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        buttonNavController()
        navBar()
        buscarFuncionario()
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
        
        registerVC.atualizarFuncionariosDelegate = self
        
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
        let nib = UINib(nibName: "FuncionarioTableViewCell", bundle: nil)
        nomesTableView.register(nib, forCellReuseIdentifier: "FuncionarioCell")
        nomesTableView.dataSource = self
        nomesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nomesTableView.dequeueReusableCell(withIdentifier: "FuncionarioCell", for: indexPath) as! FuncionarioTableViewCell
        let funcionario = self.items![indexPath.row]
        cell.textLabel?.text = (funcionario.nome) + " " +  (funcionario.sobrenome)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            context.delete(self.items![indexPath.row])
            
            updateContext()
            
            func updateContext() {
                do {
                    try context.save()
                    items?.removeAll()
                    buscarFuncionario()
                    nomesTableView.reloadData()
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ViewController: AtualizarFuncionariosDelegate {
    func adicionar(funcionario: FuncionarioInput) {
        print(funcionario)
        func updateContext() {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        var newRequest: NSManagedObject?
        guard let entity = NSEntityDescription.entity(forEntityName: "Funcionario", in: context) else { return }
        newRequest = NSManagedObject(entity: entity, insertInto: context)
        newRequest?.setValue(funcionario.nome, forKey: "nome")
        newRequest?.setValue(funcionario.sobrenome, forKey: "sobrenome")
        newRequest?.setValue(funcionario.dataNascimento, forKey: "dataNascimento")
        newRequest?.setValue(funcionario.cargo, forKey: "cargo")
        newRequest?.setValue(funcionario.nivelExperiencia, forKey: "nivelExperiencia")
        updateContext()
    }
    
    func buscarFuncionario() {
        do {
            self.items = try context.fetch(Funcionario.fetchRequest())
            DispatchQueue.main.async {
                self.nomesTableView.reloadData()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

