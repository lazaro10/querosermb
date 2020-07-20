//
//  Dynamic.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 14/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
