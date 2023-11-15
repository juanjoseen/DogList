//
//  DBHelper.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import Foundation
import SQLite3

class DBHelper {
    
    var dbPath: String {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        let name = "\(path)/db.sqlite3";
        return name;
    }
    
    private var database: OpaquePointer?
    
    private init() {
        database = openDB()
        createTable()
    }
    
    private func openDB() -> OpaquePointer? {
        var db: OpaquePointer?
        if sqlite3_open(dbPath, &db) == SQLITE_OK {
            return db
        } else {
            print("Can't open DB :(")
            return nil
        }
    }
    
    private func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Dogs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name CHAR(255),
        description CHAR(255),
        image CHAR(255),
        age INT);
        """
        
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(database, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Dogs table created")
            } else {
                print("Dogs table were not created")
            }
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    public static let shared: DBHelper = DBHelper()
    
    public func insertDog(_ dog: Dog) {
        var insertStatement: OpaquePointer?
        let queryString = "INSERT INTO Dogs(name, description, image, age) VALUES (?, ?, ?, ?);"
        if sqlite3_prepare_v2(database, queryString, -1, &insertStatement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        sqlite3_bind_text(insertStatement, 1, (dog.dogName as NSString).utf8String, -1, nil)
        
        sqlite3_bind_text(insertStatement, 2, (dog.description as NSString).utf8String, -1, nil)
        
        sqlite3_bind_text(insertStatement, 3, (dog.image as NSString).utf8String, -1, nil)
        
        if sqlite3_bind_int(insertStatement, 4, Int32(dog.age)) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("failure binding age: \(errmsg)")
            return
        }
        
        if sqlite3_step(insertStatement) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("failure inserting dog: \(errmsg)")
            return
        }
        
    }
    
    public func getDogs() -> [Dog] {
        var dogs: [Dog] = []
        let queryString = "SELECT * FROM Dogs"
        var queryStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryString, -1, &queryStatement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
            return dogs
        }
        
        while(sqlite3_step(queryStatement) == SQLITE_ROW) {
            let name: String = String(cString: sqlite3_column_text(queryStatement, 1) )
            let description: String = String(cString: sqlite3_column_text(queryStatement, 2))
            let image: String = String(cString: sqlite3_column_text(queryStatement, 3))
            let age: Int = Int(sqlite3_column_int(queryStatement, 4))
            
            dogs.append(Dog(dogName: name, description: description, age: age, image: image))
        }
        
        return dogs
    }
}
