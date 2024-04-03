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
        orderItemPriceLabel.text = String(item.price * item.quantity)
    }
    
    func updateLabels(_ item: SelectedMenu) {
        orderItemQuantityLabel.text = String(item.quantity)
        orderItemPriceLabel.text = String(item.price * item.quantity)
    }
    
    // MARK: - DefaultCode
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
