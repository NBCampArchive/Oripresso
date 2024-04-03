//
//  MainViewController.swift
//  Oripresso
//
//  Created by t2023-m0056 on 2024/04/01.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuBottom: UIImageView!
    @IBOutlet weak var uiTableView: UITableView!
    @IBOutlet weak var uiTitle: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var floatingButton: UIButton!
    
    let data: [MenuData] = [MenuData(name: "Americano", type: .coffee),
                            MenuData(name: "Juice", type: .nonCoffee),
                            MenuData(name: "Cake", type: .cake),
                            MenuData(name: "Bread", type: .bread)]
    var selectedMenu: [MenuData] = []
    
    func tableViewDelegate() {
        uiTableView.dataSource = self
        uiTableView.delegate = self
        uiTableView.reloadData()
    }
    
    @IBAction func segmentedControlSelected(_ sender: Any) {
        uiTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.removeBorders()
        tableViewDelegate()
    }

    @IBAction func floatingButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
        if let orderListViewController = storyboard.instantiateViewController(withIdentifier: "OrderList") as? OrderListViewController {
            orderListViewController.modalPresentationStyle = .fullScreen
            self.presentFromRight(orderListViewController, animated: true)
        } else {
            print(selectedMenu)
        }
    }
}



extension UISegmentedControl {
    func removeBorders(andBackground:Bool=false) {
        setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)

    }

    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 22.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}

extension UIViewController {
    func presentFromRight(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            // 새 뷰 컨트롤러의 초기 위치를 화면 오른쪽 바깥으로 설정
            viewControllerToPresent.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            // 새 뷰 컨트롤러 뷰를 현재 뷰 위에 추가
            self.view.addSubview(viewControllerToPresent.view)
            self.addChild(viewControllerToPresent)
            
            // 애니메이션으로 뷰를 왼쪽으로 이동
            UIView.animate(withDuration: 0.5, animations: {
                viewControllerToPresent.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { finished in
                viewControllerToPresent.didMove(toParent: self)
                completion?()
            })
        } else {
            // 애니메이션이 없는 경우, 바로 뷰 컨트롤러를 추가
            self.view.addSubview(viewControllerToPresent.view)
            self.addChild(viewControllerToPresent)
            viewControllerToPresent.didMove(toParent: self)
            completion?()
        }
    }
}
