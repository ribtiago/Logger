//
//  Logger.swift
//  Logger
//

import Foundation
import os

public class Logger {
    
    private var entities: [LoggingEntity]
    
    public let category: String
    
    public init(category: String = "default") {
        let subsystem = Bundle.main.bundleIdentifier!
        let osLogEntity = OSLoggerEntity(osLog: OSLog(subsystem: subsystem, category: category))
        
        self.entities = [osLogEntity]
        self.category = category
    }
    
    public func registerEntity(_ entity: LoggingEntity) {
        self.entities.append(entity)
    }
    
    public func registerEntities(_ entities: [LoggingEntity]) {
        entities.forEach { self.registerEntity($0) }
    }
    
    public func debug(file: String = #file, line: Int = #line, function: String = #function, _ message: String) {
        let callStack = self.getCallStackString(file: file, line: line, function: function)
        self.entities.forEach {
            $0.debug("DEBUG\t\(callStack)\t\(message)", file: file, line: line, function: function)
        }
    }
    
    public func verbose(file: String = #file, line: Int = #line, function: String = #function, _ message: String) {
        let callStack = self.getCallStackString(file: file, line: line, function: function)
        self.entities.forEach {
            $0.verbose("VERBOSE\t\(callStack)\t\(message)", file: file, line: line, function: function)
        }
    }
    
    public func info(file: String = #file, line: Int = #line, function: String = #function, _ message: String) {
        let callStack = self.getCallStackString(file: file, line: line, function: function)
        self.entities.forEach {
            $0.info("INFO\t\(callStack)\t\(message)", file: file, line: line, function: function)
        }
    }
    
    public func warning(file: String = #file, line: Int = #line, function: String = #function, _ message: String) {
        let callStack = self.getCallStackString(file: file, line: line, function: function)
        self.entities.forEach {
            $0.warning("WARNING\t\(callStack)\t\(message)", file: file, line: line, function: function)
        }
    }
    
    public func error(file: String = #file, line: Int = #line, function: String = #function, _ message: String) {
        let callStack = self.getCallStackString(file: file, line: line, function: function)
        self.entities.forEach {
            $0.error("ERROR\t\(callStack)\t\(message)", file: file, line: line, function: function)
        }
    }
    
    private func getCallStackString(file: String = #file, line: Int = #line, function: String = #function) -> String {
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        let dotIndexOrLast = fileName.firstIndex(of: ".") ?? fileName.endIndex
        let fileWithoutExtension = String(fileName[fileName.startIndex..<dotIndexOrLast])
        return "[\(fileWithoutExtension)\t\(function): \(line)]"
    }
}

extension Logger {
    
    public static let `default` = Logger()
}
