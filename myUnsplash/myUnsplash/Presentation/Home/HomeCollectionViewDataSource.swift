//
//  HomeCollectionViewDataSource.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import UIKit

 final class HomeCollectionViewDataSourceAndDelegate: NSObject, UICollectionViewDataSource {
     private let viewModel = HomeViewModel(navigator: nil)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configureCellData(with: fetchPhotos(index: indexPath))
        return cell
    }
}

// MARK: Custom Method
extension HomeCollectionViewDataSourceAndDelegate {
    func fetchPhotos(index: IndexPath) -> Photo? {
        return viewModel.photos[index.item]
    }
}

// MARK: Delegate
extension HomeCollectionViewDataSourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        return CGSize(width: width, height: width)
    }
}
