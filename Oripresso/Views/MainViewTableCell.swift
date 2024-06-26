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
        $0.layer.cornerRadius = 50
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor(red: 0.098, green: 0.251, blue: 0.145, alpha: 1)
    }

    let mainViewCellTitle = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "NanumSquareRoundB", size: 17) ?? UIFont.systemFont(ofSize: 13)
    }

    let mainViewCellDescription = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "NanumSquareRoundR", size: 14) ?? UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor(red: 0.69, green: 0.67, blue: 0.71, alpha: 1.00)
    }

    let mainViewCellPrice = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "NanumSquareRoundEB", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setLayout()
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
            $0.width.height.equalTo(105)
        }
        
        mainViewCellTitle.snp.makeConstraints {
            $0.top.equalTo(mainViewCellImage.snp.top).offset(13)
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
