
import SwiftUI

struct TabBarMainView: View {
    
    // MARK: View Properties
    @State var currentTab: Tab = .home
    @Namespace var animation
    
    init(){
        // MARK: For Hiding Native Tab Bar
        UITabBar.appearance().isHidden = true
    }
    
    @State var showTabBar: Bool = true
    var body: some View {
        
        VStack {

            ZStack(alignment: .bottom) {

                TabView(selection: $currentTab) {
                    
                    Text("Home")
                        .setTabBarBackground(color: Color("CG"))
                        .tag(Tab.home)

                    Text("Rental")
                        .setTabBarBackground(color: Color("CG"))
                        .tag(Tab.rental)
                    
                    Text("Map")
                        .setTabBarBackground(color: Color("CG"))
                        .tag(Tab.pin)
                    
                    Text("Chat")
                        .setTabBarBackground(color: Color("CG"))
                        .tag(Tab.chat)
                    
                    Text("Profile")
                        .setTabBarBackground(color: Color("CG"))
                        .tag(Tab.profile)
                }
                TabBar()
                    .offset(y: showTabBar ? 0 : 130)
                    .animation(.interactiveSpring (response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showTabBar)

            }.ignoresSafeArea(.keyboard, edges: .bottom)
            
                .onReceive(NotificationCenter.default.publisher(for: .init("SHOWTABBAR"))) { _ in
                    showTabBar = true
                }
                .onReceive(NotificationCenter.default.publisher (for: .init("HIDETABBAR"))) { _ in
                    showTabBar = false
            }
        }
    }
    
    // MARK: Custom Tab Bar
    @ViewBuilder
    func TabBar()->some View{
        HStack(spacing: 0){
            ForEach(Tab.allCases ,id: \.rawValue){tab in
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 34, height: 24)
                    .foregroundColor(currentTab == tab ? .white : .black.opacity(0.5))
                    .offset(y: currentTab == tab ? -30 : 0)
                    .background(content: {
                        if currentTab == tab{
                            Circle()
                                .fill(Color("BG"))
                                .scaleEffect(2.5)
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 5, y: 10)
                                .matchedGeometryEffect(id: "CG", in: animation)
                                .offset(y: currentTab == tab ? -30 : 0)
                        }
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                    .containerShape(Rectangle())
                    .onTapGesture{
                        currentTab = tab
                    }
            }
        }
        .padding(.horizontal, 15)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.65), value: currentTab)
        .background {
            
            // MARK: Custom Corner
            CustomCorner(corners: [.topLeft, .topRight], radius: 25)
                .fill(Color("TC"))
                .ignoresSafeArea()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Extension for Setting Tab View Background
extension View {
    func showTabBar(){
        NotificationCenter.default.post(name: NSNotification.Name("SHOWTABBAR"), object: nil)
    }
    
    func hideTabBar(){
        NotificationCenter.default.post(name: NSNotification.Name("HIDETABBAR"), object: nil)
    }
    
    @ViewBuilder
    func setTabBarBackground(color: Color)->some View{
        self.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background {
                color.ignoresSafeArea()
            }
    }
}
