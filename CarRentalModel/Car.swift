
import SwiftUI

struct Car: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var imageName: String
    var carOwner: String
    var carBrand: String
    var carModel: String
    var carManufacture: String
}

var cars: [Car] = [
    
    Car(
        imageName: "Mazda",
        carOwner: "Khaled Ali",
        carBrand: "Mazda",
        carModel: "C6",
        carManufacture: "2022"),
]
