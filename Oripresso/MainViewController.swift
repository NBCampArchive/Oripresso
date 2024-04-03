//
//  MainViewController.swift
//  Oripresso
//
//  Created by t2023-m0056 on 2024/04/01.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuBottom: UIImageView!
    @IBOutlet weak var uiTableView: UITableView!
    @IBOutlet weak var uiTitle: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var floatingButton: UIButton!
    
    let data: [MenuData] = [MenuData(name: "아메리카노", type: .coffee),
                            MenuData(name: "초코블렌디드", type: .nonCoffee),
                            MenuData(name: "당근케이크", type: .cake),
                            MenuData(name: "소금빵", type: .bread),
                            MenuData(name: "에스프레소", type: .coffee),
                            MenuData(name: "레몬에이드", type: .nonCoffee),
                            MenuData(name: "레드벨벳케이크", type: .cake),
                            MenuData(name: "식빵", type: .bread),
                            MenuData(name: "아이스아메리카노", type: .coffee),
                            MenuData(name: "민트초코블렌디드", type: .nonCoffee),
                            MenuData(name: "티라미수", type: .cake),
                            MenuData(name: "크루와상", type: .bread),
                            MenuData(name: "카페라떼", type: .coffee),
                            MenuData(name: "자몽에이드", type: .nonCoffee),
                            MenuData(name: "초코케이크", type: .cake),
                            MenuData(name: "빵", type: .bread)]
    var coffee: [MenuData] = []
    var nonCoffee: [MenuData] = []
    var cake: [MenuData] = []
    var bread: [MenuData] = []
    var selectedMenu: [MenuData] = []
    
    func tableViewDelegate() {
        uiTableView.dataSource = self
        uiTableView.delegate = self
        uiTableView.reloadData()
        uiTableView.allowsMultipleSelection = true
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
        
        if let pushVC = storyboard.instantiateViewController(withIdentifier: "OrderList") as? OrderListViewController {
            self.navigationController?.pushViewController(pushVC, animated: true)
            print(selectedMenu)
        } else {
            print(selectedMenu)
        }
    }
    
    func divideType(datas: [MenuData]) {
        for data in datas {
            switch data.type {
            case .coffee:
                coffee.append(data)
            case .nonCoffee:
                nonCoffee.append(data)
            case .cake:
                cake.append(data)
            case .bread:
                bread.append(data)
            }
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.bounds.height
        let cellHeight = tableViewHeight / 4
        return cellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableCell", for: indexPath) as! MainViewTableCell
        // setCell 메서드를 호출하여 셀의 데이터를 설정합니다.
        cell.setCell(image: "americano", title: "title", description: "description", price: "4500")
        divideType(datas: data)
        switch segment.selectedSegmentIndex {
        case 0:
            cell.setCell(image: "americano", title: coffee[indexPath.row].name, description: "desciption", price: "4500")
            return cell
        case 1:
            cell.setCell(image: "americano", title: nonCoffee[indexPath.row].name, description: "desciption", price: "4500")
            return cell
        case 2:
            cell.setCell(image: "americano", title: cake[indexPath.row].name, description: "desciption", price: "4500")
            return cell
        case 3:
            cell.setCell(image: "americano", title: bread[indexPath.row].name, description: "desciption", price: "4500")
            return cell
        default:
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segment.selectedSegmentIndex {
        case 0:
            selectedMenu.append(coffee[indexPath.row])
        case 1:
            selectedMenu.append(nonCoffee[indexPath.row])
        case 2:
            selectedMenu.append(cake[indexPath.row])
        case 3:
            selectedMenu.append(bread[indexPath.row])
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.selectedMenu = selectedMenu.filter { $0.name != coffee[indexPath.row].name}
        case 1:
            self.selectedMenu = selectedMenu.filter { $0.name != nonCoffee[indexPath.row].name}
        case 2:
            self.selectedMenu = selectedMenu.filter { $0.name != cake[indexPath.row].name}
        case 3:
            self.selectedMenu = selectedMenu.filter { $0.name != bread[indexPath.row].name}
        default:
            break
        }
    }
}
