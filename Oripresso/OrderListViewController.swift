//
//  OrderListViewController.swift
//  Oripresso
//
//  Created by 유림 on 4/2/24.
//

import UIKit


struct SelectedMenu {
    let name: String
    let price: Int
    var quantity: Int
}

class OrderListViewController: UIViewController {
    var selectedMenu = [
        SelectedMenu(name: "아이스 아메리카노", price: 4500, quantity: 3),
        SelectedMenu(name: "쿠키", price: 1000, quantity: 2)
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
        
        var item = selectedMenu[indexPath.row]
        cell.quantityVariance = { variance in
            item.quantity += variance
            if item.quantity <= 0 {
                item.quantity = 1   // 수량이 1 이하로 내려가지 않도록 함
            }
            cell.updateLabels(item)
        }
        cell.configure(item, index: indexPath.row + 1)
        cell.selectionStyle = .none
        return cell
    }
    
    // swipe하여 버튼 클릭하면 delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        selectedMenu.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.reloadData()
    }
}

