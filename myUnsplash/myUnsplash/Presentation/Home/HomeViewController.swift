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
    
    let tt = UnsplashRepository<Photo>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tt.dataTask(url: NetworkTarget.list.url, method: .get) { result in
            switch result {
            case .success(let result): print(result.count)
            case .failure(let error): print("ndkjsnkhn")
            }
            
        }
        
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

