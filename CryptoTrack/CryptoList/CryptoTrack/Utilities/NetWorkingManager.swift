

import Foundation
import Combine

class NetWorkManager{
    static func download(url: URL) -> AnyPublisher<Data, Error>{
            return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handelURLResponse(output: $0) }) 
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    static func handelURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response  as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
            }
        return output.data
    }
    static func handelCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
