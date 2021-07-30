//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

/// Should be used on Views to specify that they must have a view model
public protocol ViewConfigurable {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}
