//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

public protocol ViewConfigurable {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}
