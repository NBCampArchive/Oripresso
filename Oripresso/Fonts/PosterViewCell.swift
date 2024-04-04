//
//  PosterViewCell.swift
//  Oripresso
//
//  Created by 이시안 on 4/4/24.
//

import UIKit

class PosterViewCell: UICollectionViewCell {
    
    //이것도 넣으려면 테이블뷰도 2개를 해야하나??? 단일 테이블뷰셀로 해서 2가지로 해야하나
    @IBOutlet weak var posters: UIImageView!
    
    static let identifier = "PosterViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PosterViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Model) {
       // self.posters.image = UIImage(named: model.imageName)
    }
}
