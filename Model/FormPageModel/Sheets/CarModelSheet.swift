
import SwiftUI

struct CarModelSheet: View{
    var body: some View{
        VStack{
            HStack(alignment: .center){
                Image("TOYOTA")
                    .resizable()
                    .frame(width: 50,height: 40)
                Text("TOYOTA")
            }
            .frame(width: 175, height: 85)
            .foregroundColor(Color.black)
            .background(Color("LightGray").opacity(0.3))
            .shadow(radius: 3)
            .cornerRadius(25)
            
            HStack(alignment: .center){
                Image("TOYOTA")
                    .resizable()
                    .frame(width: 50,height: 40)
                Text("TOYOTA")
            }
            .frame(width: 175, height: 85)
            .foregroundColor(Color.black)
            .background(Color("LightGray").opacity(0.3))
            .shadow(radius: 1)
            .cornerRadius(25)
 
        }.padding()
    }
}

struct CarModelSheet_Previews: PreviewProvider {
    static var previews: some View {
        CarModelSheet()
    }
}
