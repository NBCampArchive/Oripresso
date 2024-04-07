//
//  postCollectionCell.swift
//  Oripresso
//
//  Created by 박현렬 on 4/8/24.
//

import UIKit
import SnapKit
import Then

class PostCollectionCell: UICollectionViewCell {
    let postImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(postImageView)
    }
    
    private func setupConstraints() {
        postImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(with image: UIImage?) {
        postImageView.image = image
    }
}
