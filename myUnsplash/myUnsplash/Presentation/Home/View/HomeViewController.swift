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
    private var searchViewModel: SearchViewModelProtocol?
    
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
    
    convenience init(viewModel: HomeViewModelProtocol, searchViewModel: SearchViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.searchViewModel = searchViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.searchBar.delegate = self
        
        layout()
        setupLongGestureRecognizerOnCollection()
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
    
    private func setUpCollectionView() {
        dataSourceNDelegate.photos = viewModel?.state.photos
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.dataSource = dataSourceNDelegate
        collectionView.delegate = dataSourceNDelegate
        
        reloadDataCollectionView()
    }
    
    private func reloadDataCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func addAlert() {
        let alert = UIAlertController(title: "Invalid search keyword", message: "Plz check your search keyword.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Back", style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSourceNDelegate.photos?.reset()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchViewModel?.isSearchBarTextEditig(text)
        searchViewModel?.getSearchResult()
        
        guard dataSourceNDelegate.photos?.count() != 0 else { addAlert(); return }
    
        self.dataSourceNDelegate.photos = self.searchViewModel?.photos
        searchBar.resignFirstResponder()
        
        reloadDataCollectionView()
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        
        switch gestureRecognizer.state {
        case .began:
            UIView.animate(withDuration: 0.5) {
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell else {
                    return
                }
                guard let image = cell.imageView.image else { return }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        case .ended:
            UIView.animate(withDuration: 0.5) {
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell else {
                    return
                }
                cell.transform = .init(scaleX: 1, y: 1)
            }
        default: print("예아")
        }
    }
}
