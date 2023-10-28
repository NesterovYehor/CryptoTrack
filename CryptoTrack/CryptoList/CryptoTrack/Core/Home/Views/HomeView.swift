

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var refreshOfset: CGFloat = 0
    @State private var showSetings: Bool = false
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack{
            // background layer
            
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                })
                
            
            // content layer
            
            VStack{
                headerView
                
                HomeStatView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                colomnTitles
                if !showPortfolio{
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    portfolioCpinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
        .background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin),
                           isActive: $showDetailView,
                           label: {EmptyView()})
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
                
        }
        .environmentObject(dev.homeVM)

    }
}

extension HomeView{
    private var headerView: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "person.fill")
                .animation(.none)
                .background(
                    CircleButtonViewAnimation(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio{
                        showPortfolioView.toggle()
                        vm.searchText = ""
                    }
                    else{
                        showSetings.toggle()
                    }
                }
                .background(
                    NavigationLink(destination: SettingsView(),
                                   isActive: $showSetings,
                                   label: {EmptyView()})
                )
            Spacer()
            Text(showPortfolio ? "Your Portfolio" : "Live Prices")
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    private var allCoinsList: some View{
        
        
        List{
            ForEach(vm.allCoins) {coin in
                CoinRowView(coin: coin, showHoldingsColums: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
                
        }
        .listStyle(PlainListStyle())
        .refreshable {
             vm.reloadData()
            
        }
        
        
    }
    
    private func segue(coin: Coin){
        selectedCoin = coin
        showDetailView.toggle()
        
    }
    private var portfolioCpinsList: some View{
        List{
            ForEach( vm.portfolioCoins) {coin in
                CoinRowView(coin: coin, showHoldingsColums: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    
            }
                
        }
            .listStyle(PlainListStyle())
           
    }
    
    private var colomnTitles: some View{
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio{
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
