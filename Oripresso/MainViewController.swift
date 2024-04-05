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
    
    var activityIndicator: UIActivityIndicatorView!

    var cafeMenu: CafeMenu?
    var selectedCategory: String = "Coffee"
    var selectedMenus: [SelectedMenu] = []
    var displayedMenus: [Menu] = []
    var isLoading: Bool = false
    
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
        print("selectedCategory: \(selectedCategory)")
        displayedMenus.removeAll()
        uiTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        loadInitialData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.removeBorders()
        tableViewDelegate()
        uiTableView.separatorColor =  UIColor(red: 0.89, green: 0.702, blue: 0.204, alpha: 1)
        // JSON 파일에서 데이터 읽어오기
        cafeMenu = readJSONFromFile()
        setSelectedLabel()
        loadInitialData()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    // MARK: - Infinite Scroll
    func loadInitialData() {
        var category: Category?
        
        switch selectedCategory {
        case "Coffee":
            category = cafeMenu?.coffee
        case "Non-Coffee":
            category = cafeMenu?.nonCoffee
        case "Cake":
            category = cafeMenu?.desert
        case "Bread":
            category = cafeMenu?.bread
        default:
            break
        }
        
        if let category = category {
            let initialMenus = Array(category.menus.prefix(4))
            displayedMenus.append(contentsOf: initialMenus)
            uiTableView.reloadData()
        }
    }
    func loadMoreData() {
        var category: Category?
        
        switch selectedCategory {
        case "Coffee":
            category = cafeMenu?.coffee
        case "Non-Coffee":
            category = cafeMenu?.nonCoffee
        case "Cake":
            category = cafeMenu?.desert
        case "Bread":
            category = cafeMenu?.bread
        default:
            break
        }
        
        guard let category = category,
              !isLoading,
              displayedMenus.count < category.menus.count else {
            return
        }
        
        isLoading = true
        activityIndicator.startAnimating() // 인디케이터 표시
        
        // 1초 지연 후에 데이터 로드
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let currentCount = self.displayedMenus.count
            let nextCount = min(currentCount + 4, category.menus.count)
            let newMenus = Array(category.menus[currentCount..<nextCount])
            self.displayedMenus.append(contentsOf: newMenus)
            self.uiTableView.reloadData()
            
            self.isLoading = false
            self.activityIndicator.stopAnimating() // 인디케이터 숨김
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height
        {
           print("Scroll")
            loadMoreData()
        }
    }
    
    // MARK: - Floating Button
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
}

// MARK: - UISegmentedControl Extension
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
        return displayedMenus.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.bounds.height
        let cellHeight = tableViewHeight / 4
        return cellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableCell", for: indexPath) as! MainViewTableCell
        
        let menu = displayedMenus[indexPath.row]
        cell.setCell(image: menu.image, title: menu.name, description: menu.description, price: "\(menu.price) ₩")
        
        if selectedMenus.contains(where: { $0.name == menu.name }) {
            cell.backgroundColor = UIColor(red: 0.89, green: 0.702, blue: 0.204, alpha: 0.5) // 선택된 셀의 배경색 변경
        } else {
            cell.backgroundColor = .white // 선택되지 않은 셀의 배경색 변경
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
            case "Cake":
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
            case "Cake":
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
