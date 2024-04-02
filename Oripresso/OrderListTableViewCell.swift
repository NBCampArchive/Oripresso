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
    
    func configure(_ item: SelectedMenu) {
        orderItemIndexLabel.text = String(item.index)
        orderItemIndexLabel.text = item.name
        orderItemQuantityLabel.text = String(item.quantity)
        orderItemPriceLabel.text = String(item.price)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
