
import SwiftUI

struct HomeView: View {
    
    @State var currentIndex: Int = 0
    // MARK: Detail View Properties
    @State var showDetailView: Bool = false
    @State var currentDetailCar: Car?
    @Namespace var animation
    
    var body: some View{
        
        ScrollView{
            VStack(spacing: 15) {
                HeaderView()
                SearchView()
                PlantsView()
                
            }.padding(15)
                .padding(.bottom, 50)
        }
        .overlay {
            if let currentDetailCar,showDetailView{
                DetailView(showView: $showDetailView, animation: animation, car:
                            currentDetailCar)
                .transition(.asymmetric(insertion: .identity, removal: .offset(x: 0.5)))
            }
        }
    }
    
    @ViewBuilder
    func HeaderView()->some View{
        HStack{
            VStack(spacing: 7) {
                Text("My Rentals")
                    .multilineTextAlignment(.center)
                    .font(.title.bold())
                    .foregroundColor(Color("BG"))
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
    
    @ViewBuilder
    func SearchView()->some View{
        HStack(spacing: 15){
            
            HStack(spacing: 15){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                
                Divider()
                    .padding(.vertical, -6)
                
                TextField("Search", text: .constant(""))
            }
            .padding (15)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("LightGray"))
                    .opacity(0.6)
            }
        }
        .padding(.top, 15)
    }
    
    // MARK: Plant Carousel
    @ViewBuilder
    func PlantsView()->some View{
        VStack(alignment: .leading, spacing: 15) {
            
            CustomCarousel(index: $currentIndex, items: cars, spacing: 25, cardPadding: 90, id: \.id) { plant, size in
                
                InfoCardView(car: plant, size: size)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideTabBar()
                        withAnimation(.interactiveSpring (response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)){
                            currentDetailCar = plant
                            showDetailView = true
                        }
                    }
            }
            .frame(height: 400)
            .padding(.top, 80)
            .padding(.horizontal, 10)
        }
        .padding (.top, 22)
    }
    // MARK: Plant Card View
    
    @ViewBuilder
    func InfoCardView(car: Car, size: CGSize)->some View{
        ZStack {
            LinearGradient(colors: [Color("LightGray"), Color("BG")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            VStack(spacing: 10){
                
                
                // MARK: Adding Matched Geometry Effect
                VStack{
                    if currentDetailCar?.id == car.id && showDetailView{
                        Rectangle()
                            .fill(.clear)
                    } else {
                        Image(car.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        // HACK: Declare Matched Geometry Id Before All Frame And Padding
                            .matchedGeometryEffect(id: car.id, in: animation)
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                    }
                }
                .zIndex (1)
                
                HStack{
                    VStack(alignment: .leading, spacing: 7) {
                        Text(car.carOwner)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(Color("BG"))
                        
                        HStack{
                            Text(car.carBrand)
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundColor(Color("BG"))
                            
                            Spacer()
                            
                            Text(car.carModel)
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
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding([.horizontal,.top], 15)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                        .opacity(0.7)
                }
                .padding(10)
                .zIndex(0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
