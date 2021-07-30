//
//  File.swift
//  
//
//  Created by Dylan Vélez on 29/07/21.
//

import Foundation

public protocol LoggerAction {
    var logDescription: String { get }
}

public protocol LoggingService {
    func log(action: LoggerAction)
}
