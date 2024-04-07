//
//  OrderListViewController.swift
//  Oripresso
//
//  Created by 유림 on 4/2/24.
//

import UIKit

class OrderListViewController: UIViewController {
    var selectedMenu = [SelectedMenu]()
    
    @IBOutlet weak var orderListTableView: UITableView!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - Total
    func updateTotal() {
        let totalQuantity: Int = selectedMenu.reduce(0) { partialResult, item in
            return partialResult + item.quantity
        }
        let totalPrice: Int = selectedMenu.reduce(0) { partialResult, item in
            return partialResult + (item.price * item.quantity)
        }
        self.totalQuantityLabel.text = String(totalQuantity)
        self.totalPriceLabel.text = "\(numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0") ₩"
    }
    
    // MARK: - NumberFormatter
    let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // MARK: - CancelOrder
    @IBAction func tapCancelButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문을 취소하시겠습니까?", message: "담긴 주문은 전체 삭제 되고 메인화면으로 돌아갑니다", preferredStyle: .alert)
        let orderCancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        let orderDidTapButton = UIAlertAction(title: "예", style: .default) { action in
            self.selectedMenu = []               // selectedMenu 초기화
            self.orderListTableView.reloadData() // 테이블뷰 업데이트
            self.updateTotal()                   // total bar 업데이트
            
            // 메인화면으로 돌아가기
            if let mainViewController = self.navigationController?.viewControllers.first as? MainViewController {
                mainViewController.shouldResetDisplayedMenus = true
            }
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(orderCancelAction)
        alert.addAction(orderDidTapButton)
        
        self.present(alert, animated: true)
    }
    // MARK: - ConductOrder
    @IBAction func tapOrderButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문하시겠습니까?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        let didTapButton = UIAlertAction(title: "예", style: .default) { action in
            // 주문 완료 후 주문완료 화면으로 이동
            let storyboard = UIStoryboard(name: "Payment", bundle: nil)
            
            if let pushVC = storyboard.instantiateViewController(withIdentifier: "Payment") as? PaymentsViewController {
                pushVC.navigationItem.title = ""
                self.navigationController?.pushViewController(pushVC, animated: true)
            } else {
                print("Error")
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(didTapButton)
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTotal()
        orderListTableView.dataSource = self
        let titleImage = UIImage(named: "title")
        navigationItem.titleView = UIImageView(image: titleImage)
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // MainViewController로 메뉴 데이터 보내기
        if let mainViewController = self.navigationController?.viewControllers.first as? MainViewController {
            mainViewController.selectedMenus = self.selectedMenu
        }
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
        
        cell.quantityVariance = { variance in
            self.selectedMenu[indexPath.row].quantity += variance
            if self.selectedMenu[indexPath.row].quantity <= 0 {
                self.selectedMenu[indexPath.row].quantity = 1   // 수량이 1 이하로 내려가지 않도록 함
            }
            cell.updateLabels(self.selectedMenu[indexPath.row])
            self.updateTotal()
        }
        cell.configure(selectedMenu[indexPath.row], index: indexPath.row + 1)
        cell.selectionStyle = .none
        return cell
    }
    
    // swipe하여 버튼 클릭하면 delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        selectedMenu.remove(at: indexPath.row)
        tableView.reloadData() // 모든 셀의 index label을 업데이트해야해서 reloadData 사용함
    }
}

