//
//  orderButtonViewController.swift
//  Oripresso
//
//  Created by t2023-m0074 on 4/2/24.
//

import UIKit

class orderButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        var alert = UIAlertController(title: "주문하시겠습니까?", message: "", preferredStyle: .alert)
        var cancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        var didTapButton = UIAlertAction(title: "예", style: .default) { action in
        }
        alert.addAction(cancelAction)
        alert.addAction(didTapButton)
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func orderCancelButton(_ sender: UIButton) {
        var alert = UIAlertController(title: "주문을 취소하시겠습니까?", message: "담긴 주문은 전체 삭제 되고 메인화면으로 돌아갑니다", preferredStyle: .alert)
        var orderCancelAction = UIAlertAction(title: "아니요", style: .destructive) { action in
        }
        var orderDidTapButton = UIAlertAction(title: "예", style: .default) { action in
        }
        alert.addAction(orderCancelAction)
        alert.addAction(orderDidTapButton)
        
        self.present(alert, animated: true)
    }
    
    
}
