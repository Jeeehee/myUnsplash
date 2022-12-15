//
//  Photos.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

final class Photos {
    private var list: [Photo] = []
    
    subscript(index: Int) -> Photo {
        return list[index]
    }
    
    func count() -> Int {
        return list.count
    }
    
    func append(_ element: [Photo]) {
        print(element.count)
        element.forEach { list.append($0) }
    }
    
    func reset() {
        list.removeAll()
    }
}
