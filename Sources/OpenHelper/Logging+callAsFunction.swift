//
//  DebugAndLogging.swift
//  OpenHelper
//
//  Created by Marco Boerner on 08.07.21.
//

import Foundation
import os

/// This is a wrapper around the os.Logger class. It adds a few convenience methods and a custom initializer.
public extension Logger {

	/// Initializes logger instance with a new category. Automatically using the bundleIdentifier as subsystem.
	init(category: String) {
        self.init(subsystem: Bundle.main.bundleIdentifier!, category: category + String(repeating: " ", count: 9 - category.count))
	}

    /// This method logs the workflow and reducer actions and formats it for better debugging.
    func callAsFunction(action: Any, file: String = #fileID, line: Int = #line) {
        // Removing closing brackets from the action, if any.
        let action = "\(action)".hasSuffix(")") ? "\(action)".dropLast() : "\(action)"

        // Shortening the action string to 100 and splitting it at the opening bracket if the enum has a value
        let split = (action.count > 80 ? "\(action.prefix(100))..." : action)
            .split(separator: "(", maxSplits: 1)

        // Adding empty spaces in between the action enum case and its value. Repeating " " to align the output
        // and max() in case we ran into a too long enum case that will cause a fatal error
        let message = split.joined(separator: String(repeating: " ", count: max(30 - split[0].count, 1)))

        // Doing the same align adjustment with the file and line infos.
        let fileAndLine = "[\(file):\(line)\(String(repeating: " ", count: max(55 - "[\(file):\(line)]".count, 1)))]"

        // And finally printing to the console
        self.debug("\(fileAndLine)  >  \(message)")
    }

    func callAsFunction(error message: String, file: String = #fileID, line: Int = #line) {
        self.error("[\(file):\(line)] 🛑 \(message)")
    }

    func callAsFunction(info message: String, file: String = #fileID, line: Int = #line) {
        self.info("[\(file):\(line)] ℹ️ \(message)")
    }

    func callAsFunction(debug message: String, file: String = #fileID, line: Int = #line) {
        self.debug("[\(file):\(line)] 🐞 \(message)")
    }

    func callAsFunction(critical message: String, file: String = #fileID, line: Int = #line) {
        self.critical("[\(file):\(line)] ⛔️ \(message)")
    }

    func callAsFunction(fault message: String, file: String = #fileID, line: Int = #line) {
        self.fault("[\(file):\(line)] 🚫 \(message)")
    }

    func callAsFunction(notice message: String, file: String = #fileID, line: Int = #line) {
        self.notice("[\(file):\(line)] \(message)")
    }

    func callAsFunction(trace message: String, file: String = #fileID, line: Int = #line) {
        self.trace("[\(file):\(line)] ⁉️ \(message)")
    }

    func callAsFunction(warning message: String, file: String = #fileID, line: Int = #line) {
        self.warning("[\(file):\(line)] ⚠️ \(message)")
    }

    func callAsFunction(log message: String, file: String = #fileID, line: Int = #line) {
        self.log("[\(file):\(line)] \(message)")
    }

}

