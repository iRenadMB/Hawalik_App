
import SwiftUI
struct OnBoardingStep {
    let image : String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "onBoarding1", title: "", description:"Hwalek application shows you cars for rent from their owners" ),
    OnBoardingStep(image: "onBoarding5", title: "", description:"You can see the nearest car to you" ),
    OnBoardingStep(image: "onBoarding3", title: "", description:"Book it quickly and easily" ),
    OnBoardingStep(image: "onBoarding4", title: "", description:"You can add your car and offer it for rent" )
]

struct OnBoarding: View {
    
    @State private var currentStep = 0
    @State var showFullScreen: Bool = false
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        VStack{
            
            HStack{
                Spacer()
                Button(action: {
                    self.currentStep = onBoardingSteps.count - 1
                }){
                    Text("Skip")
                        .font(.title3)
                        .padding(16)
                        .foregroundColor(.gray)
                }}
            
            TabView(selection: $currentStep){
                ForEach(0..<onBoardingSteps.count) {it in
                    
                    VStack{
                        
                        Image(onBoardingSteps[it].image)
                            .resizable()
                        
                            .frame(maxWidth: .infinity, maxHeight: 390)
                        Text(onBoardingSteps[it].title)
                            .font(.title)
                            .bold()
                        
                        Text(onBoardingSteps[it].description)
                            .font(.title2)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                    }
                    .tag(it)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
            
            HStack{                 ForEach(0..<onBoardingSteps.count) {it in
                if it == currentStep {
                    Rectangle()
                        .frame(width: 20,height: 10)
                        .cornerRadius(10)
                        .foregroundColor(.gray)
                }else{
                    Circle()
                        .frame(width: 10,height: 10)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
                
            }
            }
            
            Button(action:{
                if self.currentStep < onBoardingSteps.count - 1 {
                    self.currentStep += 1
                }else{
                    showFullScreen.toggle()
                }
            }){
                Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get started")
                
                    .font(.title2)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color("BG"))
                    .cornerRadius(15)
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color("LightGray"))
        .fullScreenCover(isPresented: $showFullScreen) { BaseView() }
    }
    
    struct OnBoarding_Previews: PreviewProvider {
        static var previews: some View {
            OnBoarding()
        }
    }
}
