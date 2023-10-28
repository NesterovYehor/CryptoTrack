

import SwiftUI

struct SettingsView: View {
    @State private var vm = SettingsViewModel()
    @State private var showRegisterSheet: Bool = false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showRegisterSheet, content: {
                    LoginView()
                })
            
            VStack{
                logInAndRegisterButton
                Divider()
                setingsButton
                Divider()
                helpAndSupportButton
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.isSchemeDark.toggle()
                    } label: {
                        Image(systemName: "sun.min.fill")
                            .foregroundColor(Color.theme.accent)
                            .font(.title3)
                    }.padding()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsView()
        }
        .navigationBarHidden(true)
    }
}

extension SettingsView{
    
    private var logInAndRegisterButton: some View{
        HStack{
            Image(systemName: "person.fill")
            Text("Log in or Register")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .font(.title3)
        .foregroundColor(Color.theme.accent)
        .background(Color.theme.background)
        .onTapGesture {
            withAnimation {
                showRegisterSheet.toggle()
            }
        }
    }
    private var setingsButton: some View{
        HStack{
            Image(systemName: "gearshape.fill")
            Text("Settings")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .font(.title3)
        .foregroundColor(Color.theme.accent)
        .background(Color.theme.background)
    }
    private var helpAndSupportButton: some View{
        HStack{
            Image(systemName: "questionmark.circle.fill")
            Text("Help & Support")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .font(.title3)
        .foregroundColor(Color.theme.accent)
        .background(Color.theme.background)
    }

}
