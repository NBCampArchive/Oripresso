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
    var selectedMenus: [SelectedMenu] = []

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
            pushVC.selectedMenu = selectedMenus
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            print(selectedMenus)
        } else {
            print(selectedMenus)
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

// MARK: - TableView
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
                if selectedMenus.contains(where: { $0.name == menu.name }) {
                    cell.backgroundColor = UIColor(red: 0.89, green: 0.702, blue: 0.204, alpha: 0.5) // 선택된 셀의 배경색 변경
                } else {
                    cell.backgroundColor = .white // 선택되지 않은 셀의 배경색 변경
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 배경색 변경
        if let cell = tableView.cellForRow(at: indexPath) {
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(red: 0.89, green: 0.702, blue: 0.204, alpha: 0.5)
            cell.selectedBackgroundView = bgColorView
        }
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
            
            if let selectedMenu = menu {
                if let index = selectedMenus.firstIndex(where: { $0.name == selectedMenu.name }) {
                    // 이미 선택된 메뉴인 경우 배열에서 제거
                    selectedMenus.remove(at: index)
                    
                    // 해당 셀만 갱신
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    let newSelectedMenu = SelectedMenu(name: selectedMenu.name, price: selectedMenu.price, quantity: 1)
                    selectedMenus.append(newSelectedMenu)
                }
                
                print("Selected Menus: \(selectedMenus)")
                selectedLabel.text = String(selectedMenus.count)
            }
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
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

            if let deselectedMenu = menu {
                selectedMenus = selectedMenus.filter { $0.name != deselectedMenu.name }
                print("Deselected Menu: \(deselectedMenu.name)")
            }
            print("Selected Menu: \(selectedMenus)")
            selectedLabel.text = String(selectedMenus.count)
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
