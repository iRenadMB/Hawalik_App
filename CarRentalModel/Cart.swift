
import SwiftUI

struct Cart: Identifiable{

    var id = UUID().uuidString
    var item: Car
    var quantity: Int
}
