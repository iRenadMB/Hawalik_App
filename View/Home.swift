
import SwiftUI

struct Home: View {
    
    @Binding var selectedTab: String
    @State var currentTab: Tab = .home

    // Hiding Tab Bar..
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        // Tab View With Tabs...

            TabView(selection: $selectedTab) {
                // Views..
                //            HomePage()
                //                .tag("Home")
                History()
                    .tag(Tab.home)
                //        Settings()
                //                .tag("Settings")
                //        Help()
                //                .tag("Help")
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct History: View {
    @State var showFullScreen: Bool = false

    var body: some View {
        
        NavigationView {
            
            //            Text("History")
            //                .font(.largeTitle)
            //                .fontWeight(.heavy)
            //                .foregroundColor(.primary)
            //                .navigationTitle("History")
            ZStack{
                Text("Home")
                    .setTabBarBackground(color: Color("CG"))
                TabBarMainView()
            }
        }
    }
}

// نكتب كل صفحة عندي
