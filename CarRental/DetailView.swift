
import SwiftUI

struct DetailView: View {
    
    @Binding var showView: Bool
    var animation: Namespace.ID
    var car: Car
    
    // MARK: Animation Properties
    @State var showContent: Bool = false
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            VStack(spacing: -30){
                Image(car.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: car.id, in: animation)
                    .frame(width: size.width - 50, height: size.height / 1.6)
                    .zIndex(1)
                VStack(spacing: 20){
                    HStack{
                        Text(car.carOwner)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit (2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("BG"))
                    }
                    
                    HStack{
                        Text("Brand of car")
                            .font(.title2)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("BG"))
                        
                        Text(car.carBrand)
                            .font(.title3.bold())
                            .padding(.horizontal, 15)
                            .padding(.vertical,8)
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("BG").opacity(0.6))
                            }
                    }
                    
                    HStack{
                        Text("Model of car")
                            .font(.title2)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("BG"))
                        
                        Text(car.carModel)
                            .font(.title3.bold())
                            .padding(.horizontal, 32)
                            .padding(.vertical,8)
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("BG").opacity(0.6))
                            }
                    }
                    
                    HStack{
                        Text("Manufacture of car")
                            .font(.title2)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color("BG"))
                        
                        Text(car.carManufacture)
                            .font(.title3.bold())
                            .padding(.horizontal, 22)
                            .padding(.vertical,8)
                            .foregroundColor(.white)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("BG").opacity(0.6))
                            }
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 15)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .top)
                .background(content: {
                    CustomCorner(corners: [.topLeft, .topRight], radius: 25)
                        .fill(.white)
                        .ignoresSafeArea()
                })
                .offset(y: showContent ? 0 : (size.height / 1.5))
                .zIndex(0)
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .padding(.top, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top, content: {
            HeaderView()
                .opacity(showContent ? 1 : 0)
        })
        .background {
            Rectangle()
                .fill(Color("LightGray").gradient)
                .ignoresSafeArea()
                .opacity(showContent ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35).delay(0.05)){
                showContent = true
            }
        }
    }
    
    @ViewBuilder
    func HeaderView()->some View {
        Button {
            // MARK: Closing View And Showing Tab Bar
            withAnimation(.easeInOut(duration: 0.3)){
                showContent = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                showTabBar()
                withAnimation(.easeInOut(duration: 0.35)){
                    showView = false
                }
            }
        } label: {
            Image(systemName: "chevron.left")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("BG"))
        }
        .padding(15)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
