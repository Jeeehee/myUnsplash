//
//  HomeCollectionViewDataSource.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import UIKit

final class HomeCollectionViewDataSourceAndDelegate: NSObject, UICollectionViewDataSource {
    var photos: Photos?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count() ?? 0
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
    private func fetchPhotos(index: IndexPath) -> Photo? {
        return photos?[index.item]
    }
}

// MARK: Delegate
extension HomeCollectionViewDataSourceAndDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        return CGSize(width: width, height: width)
    }
}
