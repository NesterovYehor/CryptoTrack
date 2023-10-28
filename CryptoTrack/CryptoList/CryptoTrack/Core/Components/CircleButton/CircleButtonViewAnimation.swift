

import SwiftUI

struct CircleButtonViewAnimation: View {
    
    @Binding  var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0 )
            .animation(animate ? Animation.easeOut(duration: 1) : .none)

    }
}

struct CircleButtonViewAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonViewAnimation(animate: .constant(false))
            .frame(width: 100, height: 100)
    }
}
