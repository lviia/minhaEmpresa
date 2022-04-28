//  ViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 26/01/22.
//

import UIKit
import CoreData

// MARK: - Protocol AtualizarFuncionariosDelegate
protocol AtualizarFuncionariosDelegate {
    func buscarFuncionario()
    func adicionar(funcionario: FuncionarioInput)
    func totalColaboradores()
    func nivelExperiencia()
    func cargos()
}

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var nomesTableView: UITableView!
    @IBOutlet weak var comercialLabel: UILabel!
    @IBOutlet weak var desenvolvimentoLabel: UILabel!
    @IBOutlet weak var suporteLabel: UILabel!
    @IBOutlet weak var admLabel: UILabel!
    @IBOutlet weak var totalColaboradoresLabel: UILabel!
    @IBOutlet weak var mediaSlider: UISlider!
    @IBOutlet weak var mediaLabel: UILabel!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var funcionarios:[Funcionario] = []
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        buttonNavController()
        navBar()
        buscarFuncionario()
        totalColaboradores()
        nivelExperiencia()
        cargos()
    }
    
    // MARK: - Navbar
    func navBar() {
        title = "Minha Empresa"
        navigationController?.navigationBar.backgroundColor = .orange
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Button
    func buttonNavController() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.didTapButton))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
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
        return self.funcionarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nomesTableView.dequeueReusableCell(withIdentifier: "FuncionarioCell", for: indexPath) as! FuncionarioTableViewCell
        let funcionario = self.funcionarios[indexPath.row]
        cell.textLabel?.text = (funcionario.nome) + " " +  (funcionario.sobrenome)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            context.delete(self.funcionarios[indexPath.row])
            updateContext()
            func updateContext() {
                do {
                    try context.save()
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            funcionarios.removeAll()
            buscarFuncionario()
            totalColaboradores()
            nivelExperiencia()
            cargos()
            nomesTableView.reloadData()
        }
    }
}

// MARK: - Funcionario
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
        newRequest?.setValue(funcionario.id, forKey: "id")
        updateContext()
    }
    
    func buscarFuncionario() {
        do {
            self.funcionarios = try context.fetch(Funcionario.fetchRequest())
            DispatchQueue.main.async {
                self.nomesTableView.reloadData()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func totalColaboradores() {
        totalColaboradoresLabel.text = "\(funcionarios.count)"
    }
    
    func nivelExperiencia() {
        var soma: Float = 0
        for funcionario in funcionarios {
            let nivelExp: Float = funcionario.nivelExperiencia
            soma += nivelExp
        }
        mediaSlider.value = soma / Float(funcionarios.count)
        mediaLabel.text = "\(round(mediaSlider.value))"
    }

    func cargos() {
        var somaC = 0
        var somaD = 0
        var somaS = 0
        var somaA = 0
        for funcionario in funcionarios {
            switch funcionario.cargo {
            case "Comercial": somaC += 1
            case "Desenvolvimento": somaD += 1
            case "Suporte Técnico": somaS += 1
            case "Administrativo": somaA += 1
            default:
                break
            }
        }
        comercialLabel.text = "\(somaC)"
        desenvolvimentoLabel.text = "\(somaD)"
        suporteLabel.text = "\(somaS)"
        admLabel.text = "\(somaA)"
    }
}

