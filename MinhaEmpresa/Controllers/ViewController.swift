//
//  ViewController.swift
//  MinhaEmpresa
//
//  Created by Lívia - Fulltrack Mobile on 26/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Minha Empresa"
        configTableView()
    }
    
    func configTableView() {
        personsTableView.dataSource = self
    }
}

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


