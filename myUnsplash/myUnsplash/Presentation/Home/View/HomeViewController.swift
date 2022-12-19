//
//  HomeViewController.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private lazy var dataSource = HomeCollectionViewDataSource()
    private let delegate = HomeCollectionViewDelegate()
    
    private let viewModel = HomeViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()

        dataSource.photos = viewModel.photos
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

