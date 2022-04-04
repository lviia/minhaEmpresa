//
//  Funcionario+CoreDataProperties.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 29/03/22.
//
//

import Foundation
import CoreData


extension Funcionario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Funcionario> {
        return NSFetchRequest<Funcionario>(entityName: "Funcionario")
    }

    @NSManaged public var cargo: String?
    @NSManaged public var dataNascimento: Date?
    @NSManaged public var nivelExperiencia: Float
    @NSManaged public var nome: String?
    @NSManaged public var sobrenome: String?

}

extension Funcionario : Identifiable {

}
