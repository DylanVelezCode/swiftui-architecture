//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

public protocol ViewModel: ObservableObject {
    associatedtype ViewState
    associatedtype Event
    var state: ViewState { get }
    
    func dispatch(event: Event)
}
