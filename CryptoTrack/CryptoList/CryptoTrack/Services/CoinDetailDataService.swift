
import Foundation
import Combine

class CoinDetailDataService{
    @Published var coinDetails: CoinDetail? = nil
    let coin: Coin
    
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: Coin){
        self.coin  = coin
        getCoinDetails()
    }
    
     func getCoinDetails(){
         guard let  url = URL(string:  "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else {return}
         coinDetailSubscription = NetWorkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetWorkManager.handelCompletion, receiveValue: { [weak self] returnCoinDeatils in
                self?.coinDetails = returnCoinDeatils
                self?.coinDetailSubscription?.cancel( )
            })
            
    }
}
