//
//  OrderListTableViewCell.swift
//  Oripresso
//
//  Created by 유림 on 4/2/24.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var orderItemIndexLabel: UILabel!
    @IBOutlet weak var orderItemNameLabel: UILabel!
    @IBOutlet weak var orderItemQuantityLabel: UILabel!
    @IBOutlet weak var orderItemPriceLabel: UILabel!
    
    // MARK: - QuantityChange
    var quantityVariance: ((Int) -> Void)?
    @IBAction func tapMinusButton(_ sender: UIButton) {
        quantityVariance?(-1)
    }
    @IBAction func tapPlusButton(_ sender: UIButton) {
        quantityVariance?(+1)
    }
    
    // MARK: - IndexUpdate
    var indexUpdate: ((Int) -> Void)?
    
    // MARK: - CellConfiguration
    func configure(_ item: SelectedMenu, index: Int) {
        orderItemIndexLabel.text = String(index)
        orderItemNameLabel.text = item.name
        orderItemQuantityLabel.text = String(item.quantity)
        orderItemPriceLabel.text = "\(numberFormatter.string(from: NSNumber(value: item.price * item.quantity)) ?? "0") ₩"
    }
    
    func updateLabels(_ item: SelectedMenu) {
        orderItemQuantityLabel.text = String(item.quantity)
        orderItemPriceLabel.text = "\(numberFormatter.string(from: NSNumber(value: item.price * item.quantity)) ?? "0") ₩"
    }
    
    // MARK: - NumberFormatter
    let numberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    
    // MARK: - DefaultCode
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setLayout(){
        orderItemNameLabel.font = UIFont(name: "NanumSquareRoundB", size: 17)
        orderItemIndexLabel.font = UIFont(name: "NanumSquareRoundR", size: 14)
        orderItemPriceLabel.font = UIFont(name: "NanumSquareRoundEB", size: 17)
    }

}
