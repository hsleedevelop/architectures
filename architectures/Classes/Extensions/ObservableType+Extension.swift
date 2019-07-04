//
//  ObservableType+Extension.swift
//  ShopListFilter
//
//  Created by Jason Lee on 27/04/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


/// extesion concept from Moya RxSwift
///Moya 구현 대신 비교적 간단한 스펙이라서 직접 구현함.
extension Data {
    func map<T: Decodable>(_ type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            return try decoder.decode(T.self, from: self)
        } catch let error {
            throw error
        }
    }
}

/// extesion from Moya RxSwift
extension ObservableType where E == Data {
    /// Maps received data at key path into a Decodable object. If the conversion fails, the signal errors.
    public func map<D: Decodable>(_ type: D.Type) -> Observable<D> {
        return flatMap { response -> Observable<D> in
            return Observable.just(try response.map(type))
        }
    }
}
