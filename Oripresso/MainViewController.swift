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
        print(selectedMenu)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") else {
            fatalError("셀이 존재 하지 않음")
        }
        
        switch segment.selectedSegmentIndex {
        case 0:
            if data[indexPath.row].type == .coffee {
                cell.textLabel?.text = data[indexPath.row].name
            }
            return cell
        case 1:
            if data[indexPath.row].type == .nonCoffee {
                cell.textLabel?.text = data[indexPath.row].name
            }
            return cell
        case 2:
            if data[indexPath.row].type == .cake {
                cell.textLabel?.text = data[indexPath.row].name
            }
            return cell
        case 3:
            if data[indexPath.row].type == .bread {
                cell.textLabel?.text = data[indexPath.row].name
            }
            return cell
        default:
            return cell
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
