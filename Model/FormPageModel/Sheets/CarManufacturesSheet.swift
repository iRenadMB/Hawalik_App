
import SwiftUI

struct CarManufacturesSheet: View {
    
    @State var showSheetScreenCarManufact = false
    @State private var number = 2023
    
    var body: some View {
        VStack{
            Group {
                Button(action: {
                    showSheetScreenCarManufact.toggle()
                }) {
                    HStack{
                        Text("Car Manufactures")
                        CustomNavBarView()
                    }
                    .padding()
                    .overlay(RoundedRectangle(
                        cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    .frame(maxWidth: 360, maxHeight: 60)
                    .foregroundColor(Color("BG"))
                }
            }
        }
        
        .sheet(isPresented: $showSheetScreenCarManufact, content: {
                VStack {
                    Picker("", selection: $number) {
                        ForEach(2000...2023, id: \.self) {
                            Text("\($0)")
                        }
                        .presentationDetents([.height(200), .medium])
                    }.pickerStyle(.wheel)
                }
        })
    }
}


struct CarManufacturesSheet_Previews: PreviewProvider {
    static var previews: some View {
        CarManufacturesSheet()
    }
}
