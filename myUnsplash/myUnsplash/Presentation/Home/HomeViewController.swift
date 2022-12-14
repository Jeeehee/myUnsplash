//
//  HomeViewController.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private let dataSource = HomeCollectionViewDataSource()
    private let delegate = HomeCollectionViewDelegate()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        layout()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

