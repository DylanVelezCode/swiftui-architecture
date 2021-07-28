//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

public protocol ViewModel: ObservableObject, Dispatching {
    associatedtype ViewState
    var state: ViewState { get }
}
