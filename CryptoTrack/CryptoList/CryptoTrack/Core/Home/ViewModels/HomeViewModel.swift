

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject{
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var searchText = ""
    @Published var sortOption: SortOption = .rank
    
    private let marketDataService = MarketDataService()
    private let coinsDataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    var statistic: [Statistic] = []
    
    enum SortOption{
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init(){
        addSubscribers()
        }
    func addSubscribers(){
        
//      update allcoins
        $searchText
            .combineLatest(coinsDataService.$allCoins, $sortOption)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellabels )
//      update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStat in
                self?.statistic = returnedStat
                self?.isLoading = false

            }
            .store(in: &cancellabels)
//      update portfolioData
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfoloiCoins )
            .sink { [weak self] returnedCoins in
                guard let self = self else{return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellabels)
            
         

    }
    
     func updatePortfolio(coin: Coin, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData(){
        isLoading = true
        coinsDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func mapAllCoinsToPortfoloiCoins(allCoins: [Coin], portfolioCoins: [PortfolioEntity]) -> [Coin]{
        allCoins
            .compactMap { (coin) in
                guard let entity = portfolioCoins.first(where: { $0.coinID == coin.id}) else{
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin]{
        //filter
        var updatedCoins = filterOfCoins(text: text, coins: coins)
        sortOfCoins(coins: &updatedCoins, sort: sort)

        // sort
        return updatedCoins
    }
    
    private func sortOfCoins(coins: inout [Coin], sort: SortOption){
        switch sort{
        case .rank, .holdings:
             coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
             coins.sort(by: {$0.rank > $1.rank})
        case .price:
             coins.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceReversed:
             coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin]{
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })

        default:
            return coins

        }
    }
    
    private func filterOfCoins (text: String, coins: [Coin]) -> [Coin]{
        guard !text.isEmpty else{
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool  in
            return coin.name.lowercased().contains(lowercasedText) ||
                coin.symbol.lowercased().contains(lowercasedText) ||
                coin.id.lowercased().contains(lowercasedText)
        }
        
    }
    
    
    
    private func mapGlobalMarketData(marketDataModel: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
            var stats: [Statistic] = []
        
            guard let data = marketDataModel else {
                return stats
            }
            
            let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            let volume = Statistic(title: "24h Volume", value: data.volume)
            let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
            
            let portfolioValue =
                portfolioCoins
                    .map({ $0.currentHoldingsValue })
                    .reduce(0, +)
            
            let previousValue =
                portfolioCoins
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingsValue
                        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                        let previousValue = currentValue / (1 + percentChange)
                        return previousValue
                    }
                    .reduce(0, +)

            let percentageChange = ((portfolioValue - previousValue) / previousValue)
            
            let portfolio = Statistic(
                title: "Portfolio Value",
                value: portfolioValue.asCurrencyWith2Decimals(),
                percentageChange: percentageChange)
            
            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
            return stats
        }
}

