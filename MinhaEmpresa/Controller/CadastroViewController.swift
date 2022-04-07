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
    var nivelExperiencia: Float
    var nome: String
    var sobrenome: String
}

class CadastroViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var sobrenomeTextField: UITextField!
    @IBOutlet weak var dataNascimentoDatePicker: UIDatePicker!
    @IBOutlet var cargoPickerView: UIPickerView!
    var cargoSelecionado: String = "Desenvolvimento"
    var nivelSelecionado: Float = 5.0
    
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
        let funcionario = FuncionarioInput(cargo: cargo, dataNascimento: dataNascimento, nivelExperiencia: nivelExperiencia, nome: nome!, sobrenome: sobrenome!)
        
        if nome == "" || sobrenome == "" {
            Alert(controller: self).mostra(mensagem: "Insira todos os campos corretamente")
        } else {
            atualizarFuncionariosDelegate?.adicionar(funcionario: funcionario)
            atualizarFuncionariosDelegate?.buscarFuncionario()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    var atualizarFuncionariosDelegate: AtualizarFuncionariosDelegate?
    
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
