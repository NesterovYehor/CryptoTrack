

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.title2)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.40),
                    radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleButtonView(iconName: "person.circle.fill")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
