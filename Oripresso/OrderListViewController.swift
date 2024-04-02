//
//  OrderListViewController.swift
//  Oripresso
//
//  Created by 유림 on 4/2/24.
//

import UIKit

struct SelectedMenu {
    let index: Int
    let name: String
    let price: Int
    var quantity: Int
}

class OrderListViewController: UIViewController {
    var selectedMenu = [
        SelectedMenu(index: 1, name: "아이스 아메리카노", price: 4500, quantity: 3),
        SelectedMenu(index: 2, name: "쿠키", price: 1000, quantity: 2)
        ]
    
    @IBOutlet weak var orderListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderListTableView.dataSource = self
    }
}

extension OrderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderListTableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as? OrderListTableViewCell else {
            return UITableViewCell()
        }
        
        let item = selectedMenu[indexPath.row]
        cell.configure(item)
        cell.selectionStyle = .none
        return cell
    }
}
