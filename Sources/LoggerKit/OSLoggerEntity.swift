//
//  OSLoggerEntity.swift
//  Logger
//


import Foundation
import os

struct OSLoggerEntity: LoggingEntity {
    private let osLog: OSLog
    
    init(osLog: OSLog) {
        self.osLog = osLog
    }
    
    func debug(_ log: String, file: String, line: Int, function: String) {
        os_log(.debug, log: self.osLog, "%{public}s", log)
    }
    
    func verbose(_ log: String, file: String, line: Int, function: String) {
        os_log(.info, log: self.osLog, "%{public}s", log)
    }
    
    func info(_ log: String, file: String, line: Int, function: String) {
        os_log(.default, log: self.osLog, "%{public}s", log)
    }
    
    func warning(_ log: String, file: String, line: Int, function: String) {
        os_log(.error, log: self.osLog, "%{public}s", log)
    }
    
    func error(_ log: String, file: String, line: Int, function: String) {
        os_log(.fault, log: self.osLog, "%{public}s", log)
    }
}
