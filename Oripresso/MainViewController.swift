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
    @IBOutlet weak var selectedLabel: UILabel!
    
    let data: [MenuData] = [MenuData(name: "Americano", type: .coffee),
                            MenuData(name: "Juice", type: .nonCoffee),
                            MenuData(name: "Cake", type: .cake),
                            MenuData(name: "Bread", type: .bread)]
    var cafeMenu: CafeMenu?
    var selectedCategory: String = "Coffee"
    var selectedMenu: SelectedMenu?

    var coffee: [MenuData] = []
    var nonCoffee: [MenuData] = []
    var cake: [MenuData] = []
    var bread: [MenuData] = []
   
    func tableViewDelegate() {
        uiTableView.dataSource = self
        uiTableView.delegate = self
        uiTableView.reloadData()
        uiTableView.allowsMultipleSelection = true
    }
    
    func setSelectedLabel() {
        selectedLabel.layer.cornerRadius = 22 / 2
        selectedLabel.backgroundColor = UIColor(patternImage: UIImage(named: "selectedLabelImage")!)
    }
    
    @IBAction func segmentedControlSelected(_ sender: Any) {
        selectedCategory = (sender as AnyObject).titleForSegment(at: (sender as AnyObject).selectedSegmentIndex) ?? "Coffee"
        uiTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.removeBorders()
        tableViewDelegate()
        uiTableView.separatorColor =  UIColor(red: 0.89, green: 0.702, blue: 0.204, alpha: 1)
        // JSON 파일에서 데이터 읽어오기
        cafeMenu = readJSONFromFile()
        setSelectedLabel()

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
    func removeBorders(andBackground: Bool = false) {
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
        /// SegementIndex 별 MenuData 변경
        if let cafeMenu = cafeMenu {
            var menu: Menu?
            
            switch selectedCategory {
            case "Coffee":
                menu = cafeMenu.coffee.menus[indexPath.row]
            case "Non-Coffee":
                menu = cafeMenu.nonCoffee.menus[indexPath.row]
            case "Desert":
                menu = cafeMenu.desert.menus[indexPath.row]
            case "Bread":
                menu = cafeMenu.bread.menus[indexPath.row]
            default:
                break
            }
            
            if let menu = menu {
                cell.setCell(image: "placeholder", title: menu.name, description: menu.description, price: "\(menu.price) ₩")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segment.selectedSegmentIndex {
        case 0:
            selectedMenu.append(coffee[indexPath.row])
            selectedLabel.text = String(selectedMenu.count)
        case 1:
            selectedMenu.append(nonCoffee[indexPath.row])
            selectedLabel.text = String(selectedMenu.count)
        case 2:
            selectedMenu.append(cake[indexPath.row])
            selectedLabel.text = String(selectedMenu.count)
        case 3:
            selectedMenu.append(bread[indexPath.row])
            selectedLabel.text = String(selectedMenu.count)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.selectedMenu = selectedMenu.filter { $0.name != coffee[indexPath.row].name }
            selectedLabel.text = String(selectedMenu.count)
        case 1:
            self.selectedMenu = selectedMenu.filter { $0.name != nonCoffee[indexPath.row].name }
            selectedLabel.text = String(selectedMenu.count)
        case 2:
            self.selectedMenu = selectedMenu.filter { $0.name != cake[indexPath.row].name }
            selectedLabel.text = String(selectedMenu.count)
        case 3:
            self.selectedMenu = selectedMenu.filter { $0.name != bread[indexPath.row].name }
            selectedLabel.text = String(selectedMenu.count)
        default:
            break
        }
    }
}
// MARK: - JSON 파일을 읽어오는 함수

func readJSONFromFile() -> CafeMenu? {
    if let path = Bundle.main.path(forResource: "CoffeeJson", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let cafeMenu = try decoder.decode(CafeMenu.self, from: data)
            return cafeMenu
        } catch {
            print("Error reading JSON file: \(error)")
            return nil
        }
    }
    return nil
}
