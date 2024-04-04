//
//  ViewController.swift
//  Oripresso
//
//  Created by 박현렬 on 4/1/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models.append(Model(emoji: "👽", crewName: "이시안"))
        models.append(Model(emoji: "😻", crewName: "신승현"))
        models.append(Model(emoji: "🌸", crewName: "김유림"))
        models.append(Model(emoji: "☀️", crewName: "박충건"))
        models.append(Model(emoji: "👾", crewName: "박현렬"))
        
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = (UIColor(red: 236, green: 213, blue: 146, alpha: 1))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.configure(with: models)
        return cell
    }
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
        return 825.0
    }
}

struct Model {
    let emoji: String
    let crewName: String
    init(emoji: String, crewName: String) {
        self.emoji = emoji
        self.crewName = crewName
    }
}

