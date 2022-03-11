//
//  TesteViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 04/03/22.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerViewRegister: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configPickerView()
        navbarRegister()
    }
    
    func navbarRegister() {
        view.backgroundColor = .white
        title = "Cadastro"
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // picker view
    let arrayDados = ["Comercial", "Desenvolvimento", "Suporte Técnico", "Administrativo"]
    
    func configPickerView() {
        pickerViewRegister.delegate = self
        pickerViewRegister.dataSource = self
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
}
