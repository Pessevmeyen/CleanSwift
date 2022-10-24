//
//  API.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation
import MBNetworking

enum API {
    enum Book: Networkable {
        
        case getBook(result: String)
        
        case getBookRequest(request: BookRequestModel)
        
        var request: URLRequest {
            switch self {
            case let .getBook(result):
                return getRequest(url: API.getURL(with: "\(result)", endpoint: "books.json"), queryItems: [:])
            case let .getBookRequest(request: request):
                return getRequest(url: API.getURL(endpoint: "books.json"), encodable: request)
            }
        }
    }
    
    private static func getURL(with result: String = "", encdpoint: String) -> URL {
        let baseEndpoint = "API adres\(result)/"
        return URL(forceString: "\(baseEndpoint)\(endpoint)")
    }
}
