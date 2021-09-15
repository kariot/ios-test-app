//
//  RealmHelpers.swift
//  Test App
//
//  Created by Matajar on 15/09/21.
//

import Foundation
import RealmSwift
class RealmHelpers {
    class func saveUser(user : ModelUser) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(user)
            NotificationCenter.default.post(name: .didAddNewUser, object: nil)
        }
    }
    class func getUsers() -> [ModelUser] {
        let realm = try! Realm()
        let users = realm.objects(ModelUser.self)
        return users.toArray()
    }
}
