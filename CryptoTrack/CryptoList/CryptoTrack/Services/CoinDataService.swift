

import Foundation
import Combine


class CoinDataService {
    @Published var allCoins: [Coin] = []
    
    var coinSubscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
     func getCoins(){
        guard let  url = URL(string:  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {return}
        coinSubscription = NetWorkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetWorkManager.handelCompletion, receiveValue: { [weak self] returnCoins in
                self?.allCoins = returnCoins
                self?.coinSubscription?.cancel( )
            })
            
    }
}
