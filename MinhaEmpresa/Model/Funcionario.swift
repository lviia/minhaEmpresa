//
//  Cadastro.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 21/03/22.
//

import Foundation

class Funcionario: NSObject {
    
    var nome: String
    var sobrenome: String
    var dataNascimento: Date
    var cargo: String
    var nivelExperiencia: Float
    
    init(nome: String, sobrenome: String, dataNascimento: Date, cargo: String, nivelExperiencia: Float) {
        self.nome = nome
        self.sobrenome = sobrenome
        self.dataNascimento = dataNascimento
        self.cargo = cargo
        self.nivelExperiencia = nivelExperiencia
    }
}
