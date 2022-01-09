//
//  DBManager.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/8/22.
//

import Foundation
import SQLite
import PromiseKit
import SQLiteMigrationManager

class DBManager {
    
    private let databaseFileName = Database.fileName
    
    private(set) var dbConnection         : Connection!
    private(set) var moviesManager        : MoviesManagerProtocol!
    
    static var shared: DBManager? {
        do {
           return try getShared()
        } catch _ {
            return nil
        }
    }
    
    class func databaseOpertaion<T>(block: @escaping () throws -> T) -> Promise<T> {
        return Promise<T> { seal in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let value = try block()
                    DispatchQueue.main.async {
                        seal.fulfill(value)
                    }
                } catch let error {
                    seal.reject(error)
                }
            }
        }
    }
    
    private static var sharedInstance: DBManager?

    private class func getShared() throws ->  DBManager {
        if sharedInstance == nil {
            sharedInstance = try DBManager()
        }
        return sharedInstance!
    }
    
    private init() throws {
        do {
            try openDatabaseConnection()
            moviesManager = try MoviesManager(connection: dbConnection)
        } catch {
            throw DatabaseError.cannotInitDatabase
        }
    }

    private func openDatabaseConnection() throws {
        let databasePath = try FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask,
            appropriateFor: nil, create: false).appendingPathComponent(databaseFileName).path
        print(databasePath)
        dbConnection = try Connection(databasePath)
        try dbConnection.execute("PRAGMA foreign_keys = ON")
        try dbConnection.execute("PRAGMA synchronous = OFF")
        try dbConnection.execute("PRAGMA journal_mode = MEMORY")
    }
    
    func clearAll() {
        do {
            try self.moviesManager.delete()
        } catch {
            print("Error Deleting DataBase File")
        }
    }
}
