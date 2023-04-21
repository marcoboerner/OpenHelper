//
//  File.swift
//  
//
//  Created by Marco Boerner on 21.04.23.
//

import Foundation

// Change the string representation of optional values from "nil" to "Optional(nil)"
public extension Optional {

    var debugDescription: String {
        switch self {
        case .none:
            return "Optional(nil)"
        case .some(let wrapped):
            return "Optional(\(wrapped))"
        }
    }
}
