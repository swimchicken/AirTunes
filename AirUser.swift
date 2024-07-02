//
//  User.swift
//  airtune2
//
//  Created by swimchichen on 2024/7/1.
//
//

import Foundation
import SwiftData


@Model public class User {
    var gender: Int32? = 0
    var name: String?
    var location: String?
    var age: Int16? = 0
    var style: String?
    var workstyle: String?
    var atmosphere: String?
    var id: Int32? = 0
    public init() {

    }
    
}
