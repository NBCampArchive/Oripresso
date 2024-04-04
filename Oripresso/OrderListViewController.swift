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
        SelectedMenu(name: "쿠키", price: 1000, quantity: 2),
        SelectedMenu(name: "녹차라떼", price: 5000, quantity: 5)
        ]
    
    @IBOutlet weak var orderListTableView: UITableView!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - Total
    var totalQuantity: Int = self.selectedMen
    self.totalQuantityLabel.text = String()
    
    // MARK: - Cancel
    @IBAction func tapCancelButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문을 취소하시겠습니까?", message: "담긴 주문은 전체 삭제 되고 메인화면으로 돌아갑니다", preferredStyle: .alert)
        let orderCancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        let orderDidTapButton = UIAlertAction(title: "예", style: .default) { action in
        }
        alert.addAction(orderCancelAction)
        alert.addAction(orderDidTapButton)
        
        self.present(alert, animated: true)
    }
    // MARK: - Order
    @IBAction func tapOrderButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문하시겠습니까?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        let didTapButton = UIAlertAction(title: "예", style: .default) { action in
        }
        alert.addAction(cancelAction)
        alert.addAction(didTapButton)
        
        self.present(alert, animated: true)
    }
    
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
        tableView.reloadData() // 모든 셀의 index label을 업데이트해야해서 reloadData 사용함
    }
}

