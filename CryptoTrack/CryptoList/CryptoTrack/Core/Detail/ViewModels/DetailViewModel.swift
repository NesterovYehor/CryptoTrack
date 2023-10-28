

import Foundation
import Combine
 
class DetailViewModel: ObservableObject{
    @Published var overviewStaistics: [Statistic] = []
    @Published var additionalStaistics: [Statistic] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    @Published var coin: Coin
    private let coinDetailService: CoinDetailDataService
    private var cancellabels = Set<AnyCancellable>()
    init(coin: Coin){
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStaistics = returnedArrays.overview
                self?.additionalStaistics = returnedArrays.additional
            }
            .store(in: &cancellabels)
        
        coinDetailService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellabels)
    }
    
    private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]){
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = createAdditionalArray(coin: coin, coinDetail: coinDetail)
        return (overviewArray,additionalArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic]{
        // overview
        let price = coin.currentPrice.asCurrencyWith2Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formatedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formatedWithAbbreviations() ?? "")
        let volumeStat  = Statistic(title: "Volume", value: volume)
        
        let overviewArray: [Statistic] = [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coin: Coin, coinDetail: CoinDetail?) -> [Statistic]{
        let high = coin.high24H?.asCurrencyWith2Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith2Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.asCurrencyWith2Decimals() ?? "n/a")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "Market Capitalization Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [Statistic] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockTimeStat,
            hashingStat
        ]
        return additionalArray
    }
}

