
import SwiftUI

struct SideMenuVie: View{
    
    @Binding var showMenu: Bool
    @State var currentTab = "Map"
    
    var body: some View{
        
        ZStack {
            VStack{
                VStack{
                    Image("HawalikLogo")
                        .resizable()
                        .padding(.all)
                        .frame(maxWidth: 200, maxHeight: 150)
                    
                }
                VStack(alignment: .leading, spacing: 15){
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack(alignment: .leading, spacing: 40){
                            
                            // Tab Buttons..
                            TabButton(title: "My profile", image: "Profile")
                            TabButton(title: "My rentals", image: "Rental")
                            TabButton(title: "My card", image: "Card")
                            TabButton(title: "About Hawalik", image: "HawalikLogo")
                            // TabButton(title: "QR code", image: "QR")
                            TabButton(title: "Support", image: "Support")
                        }
                        .padding()
                        .padding(.leading, 5)
                    }
                    
                    Button{
                    }label:{
                        Image("Logout")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                        Text("Log out")
                    }
                    .padding([.horizontal, .top], 15)
                    .foregroundColor(Color("BG"))
                }
            }
            
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
            // Max Width..
            .frame(width: getRect().width - 90)
            .frame(maxHeight: .infinity)
            .background(
                Color("LightGray")
                    .ignoresSafeArea(.container, edges: .vertical)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    @ViewBuilder
    func TabButton(title: String, image: String)->some View{
        
        NavigationLink{
            
            Text("\(title) View")
                .navigationTitle(title)
            
        }label:{
            HStack(spacing: 14){
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 22, maxHeight: 20)
                Text(title)
            }
            .foregroundColor(Color("BG"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SideMenuVie_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

// Extention View to get Screen Rect
extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
