//
//  Observable.swift
//  CSTV-iOS
//
//  Created by Fuze on 31/03/22.
//

import Foundation

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    var value: Value {
        didSet {
            self.notifyObservers()
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    deinit {
        self.observers.removeAll()
    }
    
    func addObserver(_ observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        self.observers.append(Observer(observer: observer, block: observerBlock))
    }
    
    func addAndNotify(observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        self.addObserver(observer, observerBlock: observerBlock)
        observerBlock(self.value)
    }
    
    func remove(observer: AnyObject) {
        self.observers = self.observers.filter { $0.observer !== observer }
    }
    
    func notifyObservers() {
        for observer in observers {
            if Thread.isMainThread {
                observer.block(self.value)
            } else {
                DispatchQueue.main.async {
                    observer.block(self.value)
                }
            }
        }
    }
}
