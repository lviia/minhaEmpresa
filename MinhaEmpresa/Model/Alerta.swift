//
//  Alert.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 07/04/22.
//

import Foundation
import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func mostra(titulo: String = "Erro ao salvar", mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
