//
//  TesteViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 04/03/22.
//

import UIKit
import CoreData

struct FuncionarioInput {
    var cargo: String
    var dataNascimento: Date
    var id: UUID
    var nivelExperiencia: Float
    var nome: String
    var sobrenome: String
}

class CadastroViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var atualizarFuncionariosDelegate: AtualizarFuncionariosDelegate?
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var sobrenomeTextField: UITextField!
    @IBOutlet weak var dataNascimentoDatePicker: UIDatePicker!
    @IBOutlet var cargoPickerView: UIPickerView!
    var cargoSelecionado: String = "Desenvolvimento"
    var nivelSelecionado: Float = 5.0
    var id = UUID()
    
    // MARK: - IBAction
    @IBAction func nivelExperienciaSlider(_ sender: UISlider) {
        nivelSelecionado = sender.value
    }
    @IBAction func salvarButton(_ sender: Any) {
        let nome = nomeTextField.text
        let sobrenome = sobrenomeTextField.text
        let dataNascimento = dataNascimentoDatePicker.date
        let cargo = cargoSelecionado
        let nivelExperiencia = nivelSelecionado
        let funcionario = FuncionarioInput(cargo: cargo, dataNascimento: dataNascimento, id: id, nivelExperiencia: nivelExperiencia, nome: nome!, sobrenome: sobrenome!)
        
        guard let nome = nome, nome.count != 0 else {
            Alerta(controller: self).mostra(mensagem: "Insira o campo nome corretamente!")
            return
        }
        
        guard let sobrenome = sobrenome, sobrenome.count != 0 else {
            Alerta(controller: self).mostra(mensagem: "Insira o campo sobrenome corretamente!")
            return
        }
        
        if validStr(strId: nome) == false || validStr(strId: sobrenome) == false {
            Alerta(controller: self).mostra(mensagem: "Insira todos os campos corretamente!")
        } else {
            atualizarFuncionariosDelegate?.adicionar(funcionario: funcionario)
            atualizarFuncionariosDelegate?.buscarFuncionario()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Validando TextField
    
    func validStr(strId: String) -> Bool {
        let regex = "^[A-Za-z]+$"
        let strTeste = NSPredicate(format: "SELF MATCHES %@", regex)
        return strTeste.evaluate(with: strId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPickerView()
        navbarRegister()
    }
    
    // MARK: - Navbar
    func navbarRegister() {
        view.backgroundColor = .white
        title = "Cadastro"
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: - Picker View
    let arrayDados = ["Comercial", "Desenvolvimento", "Suporte Técnico", "Administrativo"]
    
    func configPickerView() {
        cargoPickerView.delegate = self
        cargoPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayDados.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.arrayDados[row] as NSString as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cargoSelecionado = arrayDados[row]
    }
}
