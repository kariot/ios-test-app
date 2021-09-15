//
//  Results+Extension.swift
//  Test App
//
//  Created by Matajar on 15/09/21.
//

import RealmSwift
extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
