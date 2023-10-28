import SwiftUI
struct ContentView: View {
    @State var preferredColorScheme: ColorScheme? = nil

    var body: some View {
        List {
                Button(action: {
                preferredColorScheme = .light
            }) {
                HStack {
                    Text("Light")
                    Spacer()
                    if preferredColorScheme == .light {
                        selectedImage
                    }
                }
            }

            Button(action: {
                preferredColorScheme = .dark
            }) {
                HStack {
                    Text("Dark")
                    Spacer()
                    if preferredColorScheme == .dark {
                        selectedImage
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .preferredColorScheme(preferredColorScheme)
        .navigationBarTitle("ColorScheme Test")
    }

    var selectedImage: some View {
        Image(systemName: "checkmark")
            .foregroundColor(.blue)
    }
}
