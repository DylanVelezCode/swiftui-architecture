//
//  File.swift
//  
//
//  Created by Dylan Vélez on 23/07/21.
//

import Foundation
import os

final class LoggerService: LoggingService {
    public func log(action: LoggerAction) {
        os_log("%{public}@", type: .info, action.logDescription)
    }
}
