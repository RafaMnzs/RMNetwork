//
//  Request.swift
//  RMNetwork
//
//  Created by Rafael Menezes on 24/05/21.
//

import Foundation

public enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public protocol Request {
    var host: String { get set }
    var path: String { get set }
    var method: Method { get set }
    var body: AnyHashable { get set }
    var query: [String: AnyHashable]? { get set }
    var params: [String: AnyHashable]? { get set }
    var header: [String: AnyHashable]? { get set }
}
