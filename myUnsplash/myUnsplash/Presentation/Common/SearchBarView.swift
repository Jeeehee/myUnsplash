//
//  SearchBarView.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import UIKit
import SnapKit

final class SearchBarView: UIView {
    lazy var searchBar: UISearchBar = {
        let image = setSearchBarBackground(color: .white, size: CGSize(width: 10, height: 100))
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search free high-resolution photos"
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .light)
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 20
        return searchBar
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
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setSearchBarBackground(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
