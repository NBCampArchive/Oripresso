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
    
    func setSegmentedControl() {
        let clearImage = UIImage()

        segment.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        segment.setDividerImage(clearImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
    }
    
    func tableViewDelegate() {
        uiTableView.dataSource = self
        uiTableView.delegate = self
        uiTableView.reloadData()
        view.addSubview(self.uiTableView)
    }
    
    @IBAction func segmentedControlSelected(_ sender: Any) {
        uiTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
        tableViewDelegate()
        floatingButton.layer.cornerRadius = 66 / 2
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

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
