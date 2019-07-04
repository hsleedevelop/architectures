//
//  API.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit

protocol API {
    var jsonData: Data { get }
    var url: String { get }
    var method: String { get }
}

enum GithubAPI: API {
    
    case viewer
    case signIn
    case notifications
    
    private var path: String {
        switch self {
        case .signIn:
            return "/callback"
        case .notifications:
            return "/notifications"
        default:
            return ""
        }
    }
    
    var method: String {
        switch self {
        case .signIn:
            return "POST"
        default:
            return "GET"
        }
    }
    
    private var queryItems: [GQLQueryItem] {
        switch self {
        case .viewer:
            return [.init("login"), .init("name")]
        default:
            return []
        }
    }
    
    private func fullQuery(_ subqueryItems: [GQLQueryItem]) -> [String: String] {
        var query: GQLQuery
        
        switch self {
        case .viewer:
            query = .init(withSchemaType: .Query,
                          withQueryTitle: "viewer",
                          withQueryArguments: nil,
                          withQueryItems: subqueryItems)
        default:
            return [:]
        }
        return [query.schemaType.rawValue: query.queryString]
    }
    
    var jsonData: Data {
        let body = self.fullQuery(self.queryItems)
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    var url: String {
        switch self {
        case .signIn:
            return "https://github.com/login/oauth/access_token"
        case .notifications:
            return Environment.domain + self.path
        default:
            return ""
        }
    }
}
