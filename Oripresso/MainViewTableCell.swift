//
//  MainViewTableCell.swift
//  Oripresso
//
//  Created by 박현렬 on 4/2/24.
//

import UIKit
import Then
import SnapKit

class MainViewTableCell: UITableViewCell {
    // MARK: - Properties
    
    let mainViewCellImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }

    let mainViewCellTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "", size: 17) ?? UIFont.systemFont(ofSize: 25)
    }

    let mainViewCellDescription = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }

    let mainViewCellPrice = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setLayout()
    }
    
    // MARK: - SetUI
    func setUI() {
        contentView.addSubview(mainViewCellImage)
        contentView.addSubview(mainViewCellTitle)
        contentView.addSubview(mainViewCellDescription)
        contentView.addSubview(mainViewCellPrice)
    }
   
    // MARK: - SetLayout
    func setLayout(){
        mainViewCellImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(28)
            $0.width.height.equalTo(80)
        }
        
        mainViewCellTitle.snp.makeConstraints {
            $0.top.equalTo(mainViewCellImage.snp.top)
            $0.leading.equalTo(mainViewCellImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        mainViewCellDescription.snp.makeConstraints {
            $0.top.equalTo(mainViewCellTitle.snp.bottom).offset(10)
            $0.leading.equalTo(mainViewCellImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        mainViewCellPrice.snp.makeConstraints {
            $0.top.equalTo(mainViewCellDescription.snp.bottom).offset(10)
            $0.leading.equalTo(mainViewCellImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - CellConfigurations
    func setCell(image: String, title: String, description: String, price: String) {
        mainViewCellImage.image = UIImage(named: image)
        mainViewCellTitle.text = title
        mainViewCellDescription.text = description
        mainViewCellPrice.text = price
    }
}
