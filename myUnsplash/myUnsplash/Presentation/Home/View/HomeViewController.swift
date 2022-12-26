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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.dataSource = dataSourceNDelegate
        collectionView.delegate = dataSourceNDelegate
        
        dataSourceNDelegate.photos = viewModel?.state.photos
        reloadDataCollectionView()
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
        
        setupLongGestureRecognizerOnCollectionView()
        layout()
    }
    
    private func bind() {
    }
    
    private func layout() {
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

// MARK: SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSourceNDelegate.photos?.reset()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let text = searchBar.text else { return }
        searchViewModel?.isSearchBarTextEditig(text)
        searchViewModel?.getSearchResult()
        
        self.dataSourceNDelegate.photos = self.searchViewModel?.photos
        reloadDataCollectionView()
        
        guard dataSourceNDelegate.photos?.count() != 0 else {
            addAlert(title: "Invalid search keyword", message: "Plz check your search keyword.", confirmMessage: "Back")
            return
        }

        reloadDataCollectionView()
    }
}

// MARK: GestureRecognizerDelegate
extension HomeViewController: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollectionView() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        
        switch gestureRecognizer.state {
        case .began: self.animationWhenPressCell(cell)
        case .ended: self.animationWhenPressEnded(cell)
        default: print("예아")
        }
    }
}

// MARK: Custom Method
extension HomeViewController {
    private func reloadDataCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func addAlert(title: String, message: String, confirmMessage: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: confirmMessage, style: .cancel)
        
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    private func animationWhenPressCell(_ cell: PhotoCell) {
        UIView.animate(withDuration: 0.5) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animationWhenPressEnded(_ cell: PhotoCell) {
        addAlert(title: "Save the photo", message: "Do you wanna save the photo to the album?", confirmMessage: "Yes")
        saveImage(cell.imageView.image)
        
        UIView.animate(withDuration: 0.5) {
            cell.transform = .init(scaleX: 1, y: 1)
        }
    }
    
    private func saveImage(_ image: UIImage?) {
        guard let image = image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
