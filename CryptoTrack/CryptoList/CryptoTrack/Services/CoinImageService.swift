

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_image"
    private let imageName: String
    
    
    init(coin: Coin) {
        self.coin = coin
        imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
             image = savedImage
        }else{
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        guard let  url = URL(string: coin.image)
        else {return}
        imageSubscription = NetWorkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetWorkManager.handelCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadImage = returnedImage else{return}
                self.image = downloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage , imageName: self.imageName, folderName: self.folderName)
            })
    }
    
}
