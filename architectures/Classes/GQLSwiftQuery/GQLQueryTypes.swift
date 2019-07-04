///https://github.com/worthbak/GQLSwiftQuery

import Foundation

// MARK: Schema Types

extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
  
  public var queryArgumentLiteral: String {
    let argKeys = Array(self.keys)
    
    var argumentString = ""
    for item in argKeys {
      let value = self[item]!
      
      if value is String {
        argumentString += "\(item):\"\(value)\""
      } else {
        argumentString += "\(item):\(value)"
      }
      
      if argKeys.last != item {
        argumentString += ","
      }
    }
    
    return argumentString
  }
  
}

public enum GQLSchemaType {
  case Query, Mutation
    var rawValue: String {
        switch self {
        case .Query:
            return "query"
        case .Mutation:
            return "mutation"
        }
    }
}

public struct GQLQuery {
    
  public init(withSchemaType schemaType: GQLSchemaType, withQueryTitle title: String, withQueryArguments arguments: [String: AnyObject]? = nil, withQueryItems queryItems: [GQLQueryItemType], includeQueryKey include: Bool = false) {
    self.schemaType = schemaType
    self.queryTitle = title
    self.arguments = arguments
    self.queryItems = queryItems
    self.includeQueryKey = include
  }
  
  public let schemaType: GQLSchemaType
  public let queryTitle: String
  public let arguments: [String: AnyObject]?
  public let queryItems: [GQLQueryItemType]
  public let includeQueryKey: Bool
  
  public var queryString: String {
    
    let argumentString: String
    if let args = self.arguments {
      argumentString = "(\(args.queryArgumentLiteral))"
    } else { argumentString = "" }
    
    let fullQuery = "{\(self.queryTitle)\(argumentString){\(self.queryItems.map { return $0.queryRepresentation }.joined(separator: ","))}}"
    
    switch self.schemaType {
    case .Query:
      return "\(self.includeQueryKey ? "query=" : "")\(fullQuery)"
    case .Mutation:
      return "\(self.includeQueryKey ? "query=" : "")mutation\(fullQuery)"
    }
  }
}

// MARK: Query Item Types / Extensions

public protocol GQLQueryItemType {
  var keyDesignation: String { get }
  var queryRepresentation: String { get }
}

extension String: GQLQueryItemType {
  public var keyDesignation: String {
    return self
  }
  
  public var queryRepresentation: String {
    return self
  }
}

public struct GQLQueryItem: GQLQueryItemType {
  
  public init(_ keyDesignation: String) {
    self.init(withKeyDesignation: keyDesignation, andSubqueryFields: nil)
  }
  
  public init(withKeyDesignation keyDesignation: String, andSubqueryFields fields: [GQLQueryItemType]?) {
    self.keyDesignation = keyDesignation
    self.fields = fields
  }
  
  public let keyDesignation: String
  public let fields: [GQLQueryItemType]?
  
  public var queryRepresentation: String {
    if let fields = self.fields {
      let subqueryString = fields.map { return $0.queryRepresentation }.joined(separator: ",")
      return "\(self.keyDesignation){\(subqueryString)}"
    } else {
      return "\(self.keyDesignation)"
    }
  }
  
}
