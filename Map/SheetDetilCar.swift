
import SwiftUI

struct SheetDetilCar: View {
    var body: some View {
        
        VStack(spacing: 20){
                        
        Text("Car Details")
//                .multilineTextAlignment(.center)
                .foregroundColor(Color("BG"))
                .font(.title)
                .bold()
            
            HStack{
                Text("Car owner")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))
                
                Spacer()
                
                Text("Mazda")
                    .font(.title3.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical,8)
                    .foregroundColor(.white)

                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("BG").opacity(0.6))
                    }
            }
            
            HStack{
                Text("Model of car")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))
                
                Spacer()
                
                Text("C6")
                    .font(.title3.bold())
                    .padding(.horizontal, 30)
                    .padding(.vertical,8)
                    .foregroundColor(.white)

                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("BG").opacity(0.6))
                    }
            }
            
            HStack{
                Text("Manufacture of car")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BG"))
                
                Spacer()
                
                Text("2022")
                    .font(.title3.bold())
                    .padding(.horizontal, 20)
                    .padding(.vertical,8)
                    .foregroundColor(.white)

                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("BG").opacity(0.6))
                    }
            }


        }.padding()
    }
}

struct SheetDetilCar_Previews: PreviewProvider {
    static var previews: some View {
        SheetDetilCar()
    }
}
