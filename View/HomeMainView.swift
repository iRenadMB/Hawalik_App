
import SwiftUI

struct HomeMainView: View {
    
    // selected Tab..
    @State var selectedTab = "Home"
    @State var showMenu = false
    
    var body: some View {
        
        ZStack {
            Color("CG")
                .ignoresSafeArea()
            
            // Side Menu...
            SideMenu(selectedTab: $selectedTab)
            
            ZStack {
                
                // two background Cards.
                Color("CG")
                .opacity(0.5)
                .cornerRadius(showMenu ? 15 : 0)
                // Shadow...
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                .offset(x: showMenu ? -25 : 0)
                .padding(.vertical, 30)
                
                Color("CG")
                .opacity(0.4)
                .cornerRadius(showMenu ? 15 : 0)
                // Shadow...
                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y: 0)
                .offset(x: showMenu ? -50 : 0)
                .padding(.vertical, 60)
                
                Home(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            // Scaling And Moving The View..
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect() .width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                // Menu Button..
                Button(action: {
                    withAnimation(.spring()){
                        showMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "list.dash")
                })
                .padding()
                ,alignment: .topLeading
            )
        }
    }
}


struct HomeMainView_Preview: PreviewProvider {
    static var previews: some View {
        HomeMainView()
    }
}

// Extending View To get Screen Size...
extension View {
    func getRect()->CGRect {
        
        return UIScreen.main.bounds
        
    }
}
