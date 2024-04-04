//
//  CollectionViewCell.swift
//  Oripresso
//
//  Created by 이시안 on 4/4/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var Background: UIImageView!
    
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //이모지 뒤에 원 만들어주기
        Background.backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        Background.layer.masksToBounds = true
        Background.layer.cornerRadius = Background.frame.height / 2
        
    }

    public func configure(with model: Model) {
        self.name.text = model.crewName
        self.emoji.text = model.emoji
    }
}
