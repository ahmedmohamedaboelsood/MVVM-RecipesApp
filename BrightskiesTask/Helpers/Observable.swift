//
//  Observable.swift
//  BrightskiesTask
//
//  Created by Ahmed Abo Elsood on 20/08/2023.
//

import Foundation
 
class Observable<T> {
    var value : T? {
        didSet{
            self.listener?(value)
        }
    }
    private var listener : ((T?)->Void)?
    
    init (_ value:T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?)->Void){
        listener(value)
        self.listener = listener
    }
}
