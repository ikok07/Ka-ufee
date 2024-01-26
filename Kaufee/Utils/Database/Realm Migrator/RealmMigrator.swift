//
//  RealmMigrator.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift

struct RealmMigrator {
    
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 0, migrationBlock: Self.performMigration)
        
        Realm.Configuration.defaultConfiguration = config
    }
    
}

extension RealmMigrator {
    
    static func performMigration(migration: Migration, oldSchemaVersion: UInt64) {
        if oldSchemaVersion < 1 {
            migrateToV1(migration, oldSchemaVersion)
        }
    }
    
    
    static func migrateToV1(_ migration: Migration, _ oldSchemaVersion: UInt64) {
        // Migrate to V1
    }
    
}
