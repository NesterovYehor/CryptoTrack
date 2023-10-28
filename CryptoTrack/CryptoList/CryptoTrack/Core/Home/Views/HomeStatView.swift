

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistic) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
