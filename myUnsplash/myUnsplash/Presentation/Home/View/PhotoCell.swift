//
//  PhotoCell.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import UIKit
import SnapKit

final class PhotoCell: UICollectionViewCell {
    static var identifier: String { return "\(self)" }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let photographerLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }

    private func layout() {
        contentView.addSubview(imageView)
        contentView.addSubview(photographerLable)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        photographerLable.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().offset(-20)
        }
    }
}