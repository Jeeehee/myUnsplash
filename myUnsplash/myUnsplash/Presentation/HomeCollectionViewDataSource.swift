//
//  HomeCollectionViewDataSource.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import UIKit

final class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var photos: Photos?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else { return 0 }
        return photos.count()
        
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: Custom Method
extension HomeCollectionViewDataSource {
    func fetchPhotos(index: IndexPath) -> Photo? {
        guard let photo = photos?[index.section] else { return nil }
        return photo
    }
}

// MARK: Delegate
final class HomeCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        return CGSize(width: width, height: width)
    }
}
