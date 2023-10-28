

import SwiftUI

struct LoginView: View {
    @State var text: String = ""
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 30){
                emailFild
                passwordFild
                Spacer()
            }.navigationTitle("Account Login")
                .padding(.vertical, 15)
                
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
extension LoginView{
    private var emailFild: some View{
        VStack(alignment: .leading){
            Text("Email")
                 .font(.body)
                 .foregroundColor(Color.theme.secondaryText)
                 .padding(.horizontal, 10)
             TextField("Example@email.com", text: $text)
                 .padding(.horizontal, 10)
                 .frame(maxWidth: .infinity, maxHeight: 50)
                 .background(Color.theme.background)
                 .shadow(color: Color.theme.accent.opacity(0.3), radius: 10, x: 0, y: 0)
        }
    }
    private var passwordFild: some View{
        VStack(alignment: .leading){
            Text("Password")
                 .font(.body)
                 .foregroundColor(Color.theme.secondaryText)
                 .padding(.horizontal, 10)
            SecureField("0-9 a..z ! @ #", text: $text)
                 .padding(.horizontal, 10)
                 .frame(maxWidth: .infinity, maxHeight: 50)
                 .background(Color.theme.background)
                 .shadow(color: Color.theme.accent.opacity(0.3), radius: 10, x: 0, y: 0)
        }
    }
}
