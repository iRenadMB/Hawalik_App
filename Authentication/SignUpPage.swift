
import SwiftUI
import FirebaseAuth

struct SignUpPage: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String? = nil
    @State private var isSuccess: Bool = false
    @State private var showPassword = false
    @State private var showPassword2 = false
    @State private var isFormValid = false
    
    var body: some View{
        
        NavigationView{
            
            ZStack{
                GradientBackground(
                    startColor: Color("LightGray"),
                    endColor: Color("BG"),
                    startPoint: .center,
                    endPoint: .topLeading)
                
                VStack(spacing: 25){
                    
                    VStack(spacing: 20){
                        Text("Sign up")
                            .font(.title).bold()
                        
                        Text("We're excited to you for joining us")
                            .font(.title3).bold()
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("BG"))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        
                        TextField("Email address", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .foregroundColor(email.isEmpty || isValidEmail(email) ? Color.black : Color.red)
                            .onChange(of: email) { newValue in
                                updateFormValidity()
                            }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button(action: { self.showPassword.toggle() }) {
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)
                        if showPassword2 {
                            TextField("Confirm password", text: $confirmPassword)
                        } else {
                            SecureField("Confirm password", text: $confirmPassword)
                        }
                        
                        Button(action: { self.showPassword2.toggle() }){
                            Image(systemName: "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    HStack(alignment: .center) {
                        Image(systemName: "phone")
                            .foregroundColor(.secondary)
                        TextField("Phone number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                            .onChange(of: phoneNumber) { newValue in
                                updateFormValidity()
                            }
                    }
                    .padding()
                    .background(Capsule().fill(Color.white))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    if isSuccess {
                        FormPage()
                    }
                    
                    Spacer()
                    
                    VStack{
                        Button(action: SignUp){
                            Text("Sign up")
                                .font(.headline)
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(isFormValid ? Color("BG") : Color.gray.opacity(0.7))
                                .cornerRadius(25)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .disabled(!isFormValid)
                        
                        HStack{
                            Text("Already have an account?")
                            NavigationLink(destination: LogInPage()) {
                                Text("Log in")
                                    .underline().bold()
                            }
                        }.foregroundColor(Color("BG"))
                    }
                }
                .padding(.top ,100)
                .padding(.bottom ,40)
                .padding(.horizontal ,20)
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func SignUp(){
        if password != confirmPassword{
            errorMessage = "Passwords do not match"
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isSuccess = true
                errorMessage = nil
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func updateFormValidity(){
        isFormValid = !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !phoneNumber.isEmpty && isValidEmail(email)
    }
}


struct SignUp_Previews: PreviewProvider{
    static var previews: some View{
        SignUpPage()
    }
}
