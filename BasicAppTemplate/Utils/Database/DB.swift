//
//  DB.swift
//  BasicAppTemplate
//
//  Created by Kaloyan Petkov on 10.12.23.
//

import Foundation
import RealmSwift

struct DB {
    
    static var shared = DB()
    private init() {}
    
    var realm = try? Realm()
    
    func save(_ object: Object) {
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch {
            print("FAILED SAVING MODEL TO REALM DB")
        }
    }
    
    func fetch<T: Object>() -> Results<T>? {
        return realm?.objects(T.self)
    }
    
    func delete(_ object: Object) {
        realm?.delete(object)
    }
    
    func deleteAll<T: Object>(ofType: T) {
        let results: Results<T>? = self.fetch()
        guard let results else {
            return
        }
        
        for result in results {
            realm?.delete(result)
        }
    }
    
    
}
