
import SwiftUI

struct CustomNavBarView: View {
    
    @State private var showBackButton: Bool = true
    @State var showSheetScreen: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                
                Spacer()

                if showBackButton {
                    backButton
                }
            }
            .accentColor(Color("BG"))
        }
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            CustomNavBarView()
            Spacer()
        }
    }
}

extension CustomNavBarView {
    
    private var backButton: some View{
        
        NavigationLink(destination: ContentView()){
            
            Button(action: {
                showSheetScreen.toggle()
                
            }, label: {
                Image(systemName: "chevron.down")
            })
        }
    }
}
