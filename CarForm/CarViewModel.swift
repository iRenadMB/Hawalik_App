
import Foundation
import FirebaseFirestore

@MainActor class CarInfoVM: ObservableObject {
    
    @Published var myInfo : [CarInfoViewModel] = []
    let db = Firestore.firestore()
    
    init(){
        fetchDataBase()
    }

    func updateData(carInfoViewModel: CarInfoViewModel) {
        let documentReference = db.collection("cars").document(carInfoViewModel.id)
        
        documentReference.updateData([
            "carOwner": carInfoViewModel.carOwner,
            "carBrand": carInfoViewModel.carBrand,
            "carManufact": carInfoViewModel.carManufact,
            "carModel": carInfoViewModel.carModel,
            "carPrice": carInfoViewModel.carPrice

        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document updated successfully")
            }
        }
    }
    
    
    func readCarInfo(userName: String, ibanCard: String, carOwner: String, carBrand: String, carModel: String, carManufact: Int, carPrice: String, statusPin: String){
        
        let info = CarInfoViewModel(userName: userName,
                                    ibanCard: ibanCard,
                                    carOwner: carOwner,
                                    carBrand: carBrand,
                                    carModel: carModel,
                                    carManufact: carManufact,
                                    carPrice: carPrice,
                                    statusPin: statusPin)
        myInfo.append(info)
    }

    
    func fetchDataBase() {
        db.collection("cars").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let userName = data["userName"] as? String ?? ""
                    let ibanCard = data["ibanCard"] as? String ?? ""
                    let carOwner = data["carOwner"] as? String ?? ""
                    let carBrand = data["carBrand"] as? String ?? ""
                    let carModel = data["carModel"] as? String ?? ""
                    let carManufact = data["carManufact"] as? Int ?? 0
                    let carPrice = data["carPrice"] as? String ?? ""

                    let statusPin = data["statusPin"] as? String ?? ""
                    
                    let cars = CarInfoViewModel(
                        userName: userName,
                        ibanCard: ibanCard,
                        carOwner: carOwner,
                        carBrand: carBrand,
                        carModel: carModel,
                        carManufact: carManufact,
                        carPrice: carPrice,
                        statusPin: statusPin
                    )

                    self.myInfo.append(cars)
                }
            }
        }
    }
}

