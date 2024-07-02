import Foundation
import SwiftData

@Model
public final class AirUser: Identifiable {
    public var id: Int32
    var gender: Int32? = 0
    var name: String?
    var location: String?
    var age: Int16? = 0
    var style: String?
    var workstyle: String?
    var atmosphere: String?

    public init(gender: Int32? = nil, name: String? = nil, location: String? = nil, age: Int16? = nil, style: String? = nil, workstyle: String? = nil, atmosphere: String? = nil, id: Int32) {
        self.gender = gender
        self.name = name
        self.location = location
        self.age = age
        self.style = style
        self.workstyle = workstyle
        self.atmosphere = atmosphere
        self.id = id
    }
}
