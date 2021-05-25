//
//  Dispatcher.swift
//  RMNetwork
//
//  Created by Rafael Menezes on 24/05/21.
//

import Foundation

protocol Dispatcher {
    func execute<T: Codable>(_ request: Request, to type: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}
