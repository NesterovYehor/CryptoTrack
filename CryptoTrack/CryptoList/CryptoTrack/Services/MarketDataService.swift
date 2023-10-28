

import Foundation

import Foundation
import Combine


class MarketDataService {
    @Published var marketData: MarketData? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
     func getData(){
        guard let  url = URL(string:  "https://api.coingecko.com/api/v3/global")
        else {return}
        marketDataSubscription = NetWorkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetWorkManager.handelCompletion, receiveValue: { [weak self] (returnedGlobalData)  in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel( )
            })
            
    }
}
