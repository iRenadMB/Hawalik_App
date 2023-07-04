
import SwiftUI

struct HomeSideMenu: View{
    
    @Binding var showMenu: Bool
    @State private var showSignupAlert = false
    @State private var isSignUp = true
    @State private var showSignUpPage = false
    
    var body: some View{
        
        ZStack{
            
            Color("LightGray")
                .ignoresSafeArea()
            
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
                        Button{
                            
                            showSignupAlert.toggle()
                            isSignUp = true
//                            FormPage()
                            
                        }label:{
                            Image(systemName: "plus.app")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundColor(Color("BG"))
                        }                        .alert(isPresented: $showSignupAlert) {
                            Alert(
                                title: Text("Sign Up"),
                                message: Text("Would you like to sign up with your existing account or create a new one?"),
                                primaryButton: .default(Text("Sign Up"), action: {
                                    if isSignUp {
                                        showSignUpPage.toggle()
                                        isSignUp = false
                                        
                                    } else {
                                        showSignUpPage.toggle()
                                        isSignUp = false
                                    }
                                }),
                                secondaryButton: .default(Text("Cancel"))
                            )
                        }.navigationBarBackButtonHidden(false)
                            .fullScreenCover(isPresented: $showSignUpPage)
                        { SignUpPage() }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
                MapViewContainer()
            }
        }
    }
}

struct HomeSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
