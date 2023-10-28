

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showChekmark: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 4){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputSection
                    }
                }
                
                .navigationTitle("Edit Portfolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        xmark
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                            tralingNavButtons
                    }
                })
                .onChange(of: vm.searchText) { value in
                    if value == "" {
                        removeSelectedCoin()
                    }
                }
                
            }
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView{
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) {coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.green : Color.clear, lineWidth: 1)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                            updateSelectedCoin(coin: coin)
                        }
                }
            }
        }
        .padding(.vertical, 4)
        .padding(.leading)
    }
    
    func getCurrentValue() -> Double{
        if let quantaty = Double(quantityText){
             return quantaty * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View{
        VStack{
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    
            }
            
            
            Divider()
            HStack{
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.45", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .font(.headline)
        .padding()
    }
    private var tralingNavButtons: some View{
        HStack{
            Image(systemName: "checkmark")
                .opacity(showChekmark ? 1.0 : 0.0)
                .foregroundColor(Color.theme.accent )
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            }).opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
        }
    }
    
    private func saveButtonPressed(){
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else {return}
        
        removeSelectedCoin()
        
        vm.updatePortfolio(coin: coin , amount: amount)
        
        withAnimation(.easeIn) {
            showChekmark = true
        }
        
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showChekmark = false
            }
        }
    }
    
    private func updateSelectedCoin(coin: Coin){
        
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings
        {
            quantityText = "\(amount)"
        }
        else{
            quantityText = ""
        }
        
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        
        vm.searchText = ""
    }
    
    private var xmark: some View{
        Button(action: {presentationMode.wrappedValue.dismiss()},label: {Image(systemName: "xmark")
               .font(.headline)})
    }
}
