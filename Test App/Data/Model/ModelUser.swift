//
//  ModelUser.swift
//  Test App
//
//  Created by Matajar on 15/09/21.
//

import RealmSwift
class ModelUser: Object {
    @Persisted var userName = ""
    @Persisted var userDOB = ""
    @Persisted var userEmail = ""
    @Persisted var userPhone = ""
    @Persisted var userSign = ""
    @Persisted var userPhoto = ""
    
}
