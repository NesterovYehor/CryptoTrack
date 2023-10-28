

import SwiftUI

struct DetailLoadingView: View{
    
    @Binding var coin: Coin?
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    private let columns:[GridItem] =
    [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
        
    init(coin: Coin){
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ChartView(coin: vm.coin)
                    .padding()
                VStack(spacing: 20){
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTralingItems
            }
        }
        
    }
}

struct DitaiView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
                .preferredColorScheme(.light)
        }
    }
}

extension DetailView{
    private var navigationBarTralingItems: some View{
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var overviewTitle: some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalTitle: some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStaistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStaistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    private var descriptionSection: some View{
        ZStack{
            if let coinDescriptions = vm.coinDescription, !coinDescriptions.isEmpty{
                VStack(alignment: .leading) {
                    Text(coinDescriptions)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut){
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }.accentColor(Color.blue)
                }.frame( maxWidth: .infinity, alignment: .leading)
            }
        }

    }
    private var websiteSection: some View{
        HStack{
            if let websiteStrng = vm.websiteURL,
               let url = URL(string: websiteStrng){
                Link("Website", destination: url)
            }
            Spacer()
            if let websiteStrng = vm.redditURL,
               let url = URL(string: websiteStrng){
                Link("Reddit", destination: url)
            }
        }
        .accentColor(Color.blue)
        .frame(maxWidth: .infinity)
        .padding(.top, 5)
    }
}
