//
//  Observable.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/12.
//

import Foundation

final class Observable<T> {
    typealias EventHandler = (T) -> Void

    struct Observer {
        weak var identifier: AnyObject?
        var handler: EventHandler
    }

    var observers: [Observer] = []

    var value: T {
        didSet {
            notifyObservers()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(to observer: AnyObject, with eventHandler: @escaping EventHandler) {
        observers.append(Observer(identifier: observer, handler: eventHandler))
        eventHandler(value)
    }

    func notifyObservers() {
        observers.forEach { observer in
            observer.handler(value)
        }
    }
}
