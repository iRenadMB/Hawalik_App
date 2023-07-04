
import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        
        
        ZStack{
            GradientBackground(startColor: Color("LightGray"), endColor: Color("BG"), startPoint: .center, endPoint: .topLeading)
            if isActive {
               OnBoarding()
               
            } else {
                
                VStack {
                    
                    VStack {
                        
                        Image("hawalik_Logo-01-removebg-preview")
                            .resizable()
                            .frame(width: 200.0, height: 130)
                    }
                    // .scaleEffect(size)
                    
                    .opacity(opacity)
                    
                    .onAppear { withAnimation(.easeIn(duration: 2)) {
                        
                        //  self.size = 0.9
                        
                        self.opacity = 1.0
                    }
                    }
                }
                
                
                .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { self.isActive = true
                }
                }
            }
            
            
        }
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
