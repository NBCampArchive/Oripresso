//
//  crewCollectionCell.swift
//  Oripresso
//
//  Created by 박현렬 on 4/8/24.
//

import UIKit
import SnapKit
import Then

class CrewCollectionCell: UICollectionViewCell {
    let crewImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 40
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .lightGray
    }
    let nameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "NanumSquareRoundEB", size: 13)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        contentView.addSubview(crewImageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setLayout() {
        crewImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(crewImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setCell(image: String, name: String) {
        crewImageView.image = UIImage(named: image)
        nameLabel.text = name
    }
}
