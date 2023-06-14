//
//  Model.swift
//  SwiftData
//
//  Created by Manav Prakash on 14/06/23.
//

import Foundation
import SwiftData

@Model
class User {
  @Attribute(.unique) var id: String?
  var name: String
  
  init(id: String, name: String) {
    self.id = id
    self.name = name
  }
}
