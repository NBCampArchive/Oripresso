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
        orderListTableView.delegate = self
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
        cell.configure(item)
        cell.selectionStyle = .none
        return cell
    }
}

extension OrderListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                    print("삭제 클릭 됨")
                    success(true)
                }
                delete.backgroundColor = .systemRed
                
                //actions배열 인덱스 0이 오른쪽에 붙어서 나옴
                return UISwipeActionsConfiguration(actions:[delete])
    }
}
