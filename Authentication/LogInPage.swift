
import SwiftUI
import FirebaseAuth

struct LogInPage: View{
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var showPassword = false
    @State private var showNextPage = false
    
    var body: some View{
        
        NavigationView{
            
            ZStack{
                GradientBackground(
                    startColor: Color("LightGray"),
                    endColor: Color("BG"),
                    startPoint: .center,
                    endPoint: .topLeading)
                
                VStack(spacing: 24){
                    
                    VStack{
                        Text("Welcome Back")
                            .padding(.all)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("BG"))
                            .font(.title).bold()
                            .padding(.bottom,25)
                    }
                    
                    HStack(alignment: .center){
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("Email address", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack{
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: { self.showPassword.toggle()}) {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                    
                    VStack {
                        
                        Button(action: Login){
                            
                            Text("Log in")
                                .font(.headline)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color("BG"))
                                .cornerRadius(25)
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                        HStack{
                            Text("Don't have an account?")
                            NavigationLink(destination: SignUpPage()){
                                Text("Sign up")
                                    .underline().bold()
                            }
                        }.foregroundColor(Color("BG"))
                    }
                }
                .padding(.top ,150)
                .padding(.bottom ,40)
                .padding(.horizontal ,20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(
                destination: FormPage(),
                isActive: $showNextPage
            ){
                EmptyView()
            }.hidden()
        )
    }
    
    func Login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Logged in successfully")
                showNextPage = true
            }
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogInPage()
    }
}

