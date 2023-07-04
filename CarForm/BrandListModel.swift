
import SwiftUI

struct InfoViewModel: Identifiable{
    var id = UUID().uuidString
    var name: String
    var image: String
}


struct CarInfoViewModel: Identifiable{
    var id = UUID().uuidString
    var userName: String
    var ibanCard: String
    var carOwner: String
    var carBrand: String
    var carModel: String
    var carManufact: Int
    var carPrice: String
    
    var statusPin: String
}
