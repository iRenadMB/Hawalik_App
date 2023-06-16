
import SwiftUI

struct HomeSideMenu: View{
    
    @Binding var showMenu: Bool
    
    var body: some View{
        
        ZStack{
            
            Color("CG")
                .ignoresSafeArea()
//                .opacity(0.5)
            VStack{
                
                VStack(spacing: 0){
                    
                    HStack{
                        
                        Button{
                            
                            withAnimation{ showMenu.toggle() }
                            
                        }label:{
                            Image(systemName: "list.bullet.indent")
                                .frame(width: 50, height: 25)
                                .foregroundColor(Color("BG"))
                        }
                        
                        Spacer()
                        
                        // Navigation Link..
                        NavigationLink{
                            
                            FormPage()
                           
                        }label:{
                            Image(systemName: "plus.app")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(Color("BG"))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                }
                Spacer()
            }
        }
    }
}

struct HomeSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
