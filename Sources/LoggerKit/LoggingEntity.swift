//
//  LoggingEntity.swift
//  Logger
//

import Foundation

public protocol LoggingEntity {
    func debug(_ log: String, file: String, line: Int, function: String)
    func verbose(_ log: String, file: String, line: Int, function: String)
    func info(_ log: String, file: String, line: Int, function: String)
    func warning(_ log: String, file: String, line: Int, function: String)
    func error(_ log: String, file: String, line: Int, function: String)
}
