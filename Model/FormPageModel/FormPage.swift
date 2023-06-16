
import SwiftUI

struct FormPage: View {
    
    @State private var showSheetScreen1 = false
    @State private var showSheetScreen2 = false
    @State private var showSheetScreen4 = false
        
    var body: some View {
        
        VStack(alignment: .center, spacing: 25){
            HStack{
                Group {
                    Button(action: {
                        showSheetScreen1.toggle()
                    }) {
                        HStack{
                            
                            Text("Car Brand")
                            CustomNavBarView()
                            
                        }.padding()
                            .overlay(RoundedRectangle(
                                cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .frame(maxWidth: 360, maxHeight: 60)
                            .foregroundColor(Color("BG"))
                    }
                }
            }
            
            HStack{
                Group {
                    Button(action: {
                        showSheetScreen2.toggle()
                    }) {
                        HStack{
                            Text("Car Model")
                            CustomNavBarView()
                            
                        }.padding()
                            .overlay(RoundedRectangle(
                                cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                            .frame(maxWidth: 360, maxHeight: 60)
                            .foregroundColor(Color("BG"))
                    }
                }
            }

            
            CarManufacturesSheet()

            
            HStack {
                Group {
                    Text("Car photo")
                    Spacer()
                    Button(action: {
                        showSheetScreen4.toggle()
                        
                    }) {
                        Image(systemName: "plus.app")
                    }
                }
            }.padding()
                .foregroundColor(Color("BG"))
                .frame(maxWidth: 375, maxHeight: 60)
        }
        
        
        .sheet(isPresented: $showSheetScreen1, content: {
            VStack {
                Text("Sheet Content")
                    .presentationDetents([.height(200), .medium])
                    .presentationDragIndicator(.automatic)
                
                Button(action: {
                    showSheetScreen1.toggle()
                }) {
                    HStack{
                        
                        Text("Car Brand")
                        CustomNavBarView()
                        
                    }.padding()
                        .overlay(RoundedRectangle(
                            cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        .frame(width: 370, height: 50)
                        .foregroundColor(Color("BG"))
                }
            }
        })
        
        .sheet(isPresented: $showSheetScreen2, content: {
            VStack {
                Text("Sheet Content")
                    .presentationDetents([.height(200), .medium])
                    .presentationDragIndicator(.automatic)
                
                Button(action: {
                    showSheetScreen2.toggle()
                }) {
                    HStack{
                        
                        Text("Car Brand")
                        CustomNavBarView()
                        
                    }.padding()
                        .overlay(RoundedRectangle(
                            cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                        .frame(width: 370, height: 50)
                        .foregroundColor(Color("BG"))
                }
            }
        })
    }
}

struct FormPage_Previews: PreviewProvider {
    static var previews: some View {
        FormPage()
    }
}


struct NewScreen: View {
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "mark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
    }
}
