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
    @IBOutlet weak var nivelLabel: UILabel!
    
    var cargoSelecionado: String = "Comercial"
    var nivelSelecionado: Float = 1.0
    var id = UUID()
    
    // MARK: - IBAction
    @IBAction func nivelExperienciaSlider(_ sender: UISlider) {
        nivelSelecionado = sender.value
        nivelLabel.text = "\(round(nivelSelecionado))"
    }
    
    @IBAction func salvarButton(_ sender: Any) {
        let nome = nomeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let sobrenome = sobrenomeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataNascimento = dataNascimentoDatePicker.date
        let cargo = cargoSelecionado
        let nivelExperiencia = nivelSelecionado
        let funcionario = FuncionarioInput(cargo: cargo, dataNascimento: dataNascimento, id: id, nivelExperiencia: nivelExperiencia, nome: nome!, sobrenome: sobrenome!)

        if validStr(strId: nome!) == false {
            Alerta(controller: self).mostra(titulo: "Erro ao salvar nome!", mensagem: "Não insira números ou caracteres especiais")
        } else if validStr(strId: sobrenome!) == false {
            Alerta(controller: self).mostra(titulo: "Erro ao salvar sobrenome!", mensagem: "Não insira números ou caracteres especiais")
        } else {
            atualizarFuncionariosDelegate?.adicionar(funcionario: funcionario)
            atualizarFuncionariosDelegate?.buscarFuncionario()
            atualizarFuncionariosDelegate?.totalColaboradores()
            atualizarFuncionariosDelegate?.nivelExperiencia()
            atualizarFuncionariosDelegate?.cargos()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Validando
    func validStr(strId: String) -> Bool {
        let regex = "[A-Za-z-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ' ']+$"
        let strTeste = NSPredicate(format: "SELF MATCHES %@", regex)
        return strTeste.evaluate(with: strId)
    }
    
    // MARK: - ViewDidLoad
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
    let arrayCargos = ["Comercial", "Desenvolvimento", "Suporte Técnico", "Administrativo"]
    
    func configPickerView() {
        cargoPickerView.delegate = self
        cargoPickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCargos.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.arrayCargos[row] as NSString as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cargoSelecionado = arrayCargos[row]
    }
}
