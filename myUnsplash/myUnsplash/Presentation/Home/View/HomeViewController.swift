//
//  HomeViewController.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol?
    private var isSearchBarTextEditig = false
    
    private let dataSourceNDelegate = HomeCollectionViewDataSourceAndDelegate()
    private let searchBarView = SearchBarView()
    
    private let tabBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    convenience init(viewModel: HomeViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.searchBar.delegate = self
        
        layout()
    }
    
    private func setUpCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.dataSource = dataSourceNDelegate
        collectionView.delegate = dataSourceNDelegate
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func bind() {
    }
    
    private func layout() {
        setUpCollectionView()
        
        view.addSubview(searchBarView)
        view.addSubview(tabBarBackgroundView)
        view.addSubview(collectionView)
        
        searchBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        tabBarBackgroundView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(tabBarBackgroundView.snp.top)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        viewModel?.isSearchBarTextEditig()
    }
}
