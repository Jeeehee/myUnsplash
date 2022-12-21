//
//  Navigator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/21.
//

import Foundation

protocol Navigator {
    var presentNextViewController: () -> Void { get }
}
