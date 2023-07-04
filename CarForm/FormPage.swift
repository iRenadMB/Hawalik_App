
import SwiftUI
import FirebaseFirestore
import Firebase

func addDataToDataBase(userName: String, ibanCard: String, carOwner: String, carBrand: String, carModel: String, carManufact: String, carPrice: String ,statusPin: String) {
    let db = Firestore.firestore()
    
    db.collection("cars").addDocument(data: [
        "userName": userName,
        "ibanCard": ibanCard,
        "carOwner": carOwner,
        "carBrand": carBrand,
        "carModel": carModel,
        "carPrice": carPrice,
        "carManufact": carManufact,
        
        "statusPin": statusPin
    ]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added successfully")
        }
    }
}


struct FormPage: View {
    
    @State var userName = ""
    @State var ibanCard = ""
    @State var carOwner = ""
    @State var carBrand = ""
    @State var carModel = ""
    @State var carManufact = 2023
    @State var carPrice = ""
    
    @State var statusPin = ""
    @State var carManufactSheet = false
    
    @State private var arbNumText: String = ""
    @State private var arbLetterText: String = ""
    @State private var engNumText: String = ""
    @State private var engLetterText: String = ""
    
    var body: some View {
        ZStack {
            GradientBackground(startColor: Color("LightGray"), endColor: Color("LightGray"), startPoint: .center, endPoint: .topLeading)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Add your car")
                        .foregroundColor(Color("BG"))
                        .font(.title)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 15){
                        
                        HStack{
                            
                            VStack(spacing: 10){
                                TextField("٤ ٣ ٢ ١", text: $arbNumText)
                                
                                Divider()
                                    .frame(height: 2)
                                    .overlay(.black)
                                
                                TextField("1 2 3 4", text: $engNumText)
                            }
                            
                            Divider()
                                .frame(width: 2)
                                .overlay(.black)
                            
                            VStack(spacing: 10){
                                TextField("أ ب د", text: $arbLetterText)
                                
                                Divider()
                                    .frame(height: 2)
                                    .overlay(.black)
                                
                                TextField("D B A", text: $engLetterText)
                            }
                            
                            Divider()
                                .frame(width: 2)
                                .overlay(.black)
                            
                            VStack(spacing: 2){
                                Image("KSA")
                                    .resizable()
                                    .frame(maxWidth: 20, maxHeight: 20)
                                Text("السعودية")
                                Text("K")
                                Text("S")
                                Text("A")
                            }
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                        }
                        .padding(5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("BG"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        
                        Text("Car owner")
                        TextField("Khaled", text: $carOwner)
                            .padding()
                            .frame(maxWidth: 350, maxHeight: 60)
                            .background(Capsule().fill(Color.white))
                        
                        
                        Text("Car brand")
                        TextField("TOYOTA", text: $carBrand)
                            .padding()
                            .frame(maxWidth: 350, maxHeight: 60)
                            .background(Capsule().fill(Color.white))
                                               
                        Text("Car model")
                        TextField("Yaris", text: $carModel)
                            .padding()
                            .frame(maxWidth: 350, maxHeight: 60)
                            .background(Capsule().fill(Color.white))
                        
                        
                        VStack(alignment: .leading){
                            
                            Text("Car manufactures")

                            Group{
                                Button(action: {
                                    carManufactSheet.toggle()
                                }) {
                                    HStack{
                                        Text("\(carManufact)")
                                        CustomNavBarView()
                                    }
                                    .padding()
                                    .frame(maxWidth: 350, maxHeight: 60)
                                    .background(Capsule().fill(Color.white))
                                }
                            }
                        }
                        .foregroundColor(Color("BG"))
                        
                        AddPhotoSheet()
                        
                    }
                    .padding()
                    .foregroundColor(Color("BG"))
                    
                    Spacer()
                    
                    Button(action: {
                        addDataToDatabase()
                        clearFields()
                        
                    }) {
                        Text("Save")
                            .font(.headline)
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color("BG"))
                            .cornerRadius(25)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .sheet(isPresented: $carManufactSheet, content: {
                    VStack{
                        Picker("", selection: $carManufact) {
                            ForEach(2000...2023, id: \.self) {
                                Text("\($0)")
                            }
                            .presentationDetents([.height(200), .medium])
                        }.pickerStyle(.wheel)
                    }
                })                .navigationBarBackButtonHidden(true)
                
            }
        }
    }
    
    func addDataToDatabase() {
        let db = Firestore.firestore()
        
        db.collection("cars").addDocument(data: [
            //            "userName": userName,
            //            "ibanCard": ibanCard,
            "carOwner": carOwner,
            "carBrand": carBrand,
            "carModel": carModel,
            "carPrice": carPrice,
            "carManufact": carManufact,
            
            "statusPin": statusPin
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added successfully")
            }
        }
    }
    
    func clearFields() {
        userName = ""
        ibanCard = ""
        carOwner = ""
        carBrand = ""
        carModel = ""
        carManufact = 0
        carPrice = ""
        statusPin = ""
    }
}


struct FormPage_Previews: PreviewProvider {
    static var previews: some View {
        FormPage()
    }
}
