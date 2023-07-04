
import SwiftUI

struct OnBoardingStep{
    let image: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(
        image: "onBoarding1",
        description:"Shows you cars for rent from their owners"),
    
    OnBoardingStep(
        image: "onBoarding5",
        description:"You can see the nearest car to you"),
    
    OnBoardingStep(
        image: "onBoarding3",
        description:"Book it quickly and easily"),
    
    OnBoardingStep(
        image: "onBoarding4",
        description:"You can add your car and offer it for rent")
]

struct OnBoarding: View{
    
    @State private var currentStep = 0
    @State var showFullScreen: Bool = false
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer()
                
                Button(action: {
                    self.currentStep = onBoardingSteps.count - 1
                }){
                    Text("Skip")
                        .font(.headline)
                        .padding(16)
                        .foregroundColor(Color("Gray"))
                }
            }
            
            TabView(selection: $currentStep){
                ForEach(0..<onBoardingSteps.count){ it in
                    
                    VStack{
                        
                        Image(onBoardingSteps[it].image)
                            .resizable()
                            .frame(maxWidth: 330, maxHeight: 300)
                        
                        Text(onBoardingSteps[it].description)
                            .font(.system(size: 25.0))
                            .font(.title).bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                    }.tag(it)
                }
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
            
            HStack{
                ForEach(0..<onBoardingSteps.count) {it in
                    if it == currentStep {
                        Rectangle()
                            .frame(width: 20,height: 10)
                            .cornerRadius(10)
                            .foregroundColor(Color("Gray"))
                    } else {
                        Circle()
                            .frame(width: 10,height: 10)
                            .foregroundColor(Color("Gray"))
                            .opacity(0.5)
                    }
                }
            }
            
            Button(action:{
                if self.currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                } else {
                    showFullScreen.toggle()
                }
            }){
                Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color("BG"))
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
            .padding(.bottom ,40)
            .padding(.horizontal ,20)
            .buttonStyle(PlainButtonStyle())
        }
        .foregroundColor(Color("Gray"))
        .background(Color("LightGray"))
        .fullScreenCover(isPresented: $showFullScreen){ BaseView()
        }.navigationBarBackButtonHidden(true)
    }
}


struct OnBoarding_Previews: PreviewProvider{
    static var previews: some View{
        OnBoarding()
    }
}
