//
//  Service.swift
//  RMNetwork
//
//  Created by Rafael Menezes on 24/05/21.
//

import Foundation

public class Service: Dispatcher {
    
    func execute<T: Codable>(_ request: Request, to type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var config = NSMutableURLRequest()
        config.addValue("application/json", forHTTPHeaderField: "Accept")
        config.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch request.method {
        case .GET:
            config.httpMethod = "GET"
            queryParams(config: &config, query: request.query)
        case .POST:
            config.httpMethod = "POST"
            config.httpBody = try? JSONSerialization.data(withJSONObject: request.body, options: .prettyPrinted)
        case .PUT:
            config.httpMethod = "PUT"
            config.httpBody = try? JSONSerialization.data(withJSONObject: request.body, options: .prettyPrinted)
        case .DELETE:
            config.httpMethod = "DELETE"
        }
        
        let session = URLSession.shared
        session.dataTask(with: config as URLRequest, completionHandler: { data, _, error  in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    guard let data = data else { return }
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }

        }).resume()
    }
}

private extension Service {
    
    private func header(config: inout NSMutableURLRequest, params: [String: AnyHashable]?) {
        guard let params = params else { return }
        for (key, value) in params {
            config.addValue("\(value)", forHTTPHeaderField: key)
        }
    }
    
    private func queryParams(config: inout NSMutableURLRequest, query: [String: AnyHashable]?) {
        guard let queries = query else { return }
        for (key, value) in queries {
            print(key)
            print(value)
        }
    }

}
