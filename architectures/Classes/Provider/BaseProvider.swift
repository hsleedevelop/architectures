//
//  BaseProvider.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

///API Base 프로바이더
class BaseProvider<T: API> {
    
}

extension BaseProvider {
    
    /// API request
    /// moya concept을 빌려옴
    /// - Parameter api: api path generic
    /// - Returns: response date
    func request(api: T) -> Observable<Data> {
        guard let encodedUrlString = api.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedUrlString) else {
                return Observable.error(NetworkError.error("잘못된 URL입니다."))
        }
        
        #if DEBUG
        print("url=\(url)")
        #endif
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = api.method
        request.setValue("token \(Environment.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        //또는 -> URLSession.shared.rx.json(request: request)
        return Observable.create { observer in
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if 200 ... 399 ~= statusCode {//서버의 응답 결과 정의 후 다양하게 처리 가능..
                        //print(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "")
                        observer.onNext(data ?? Data())
                    } else {
                        observer.onError(NetworkError.error(HTTPURLResponse.localizedString(forStatusCode: statusCode)))
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    /// API request
    /// moya concept을 빌려옴
    /// - Parameter api: api path generic
    /// - Returns: response date
    func requestQl(api: T) -> Observable<Data> {
        guard let baseURL = URL(string: Environment.domain + "/graphql") else {
            return Observable.error(NetworkError.error("잘못된 URL입니다."))
        }
        
        let request = NSMutableURLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Environment.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = api.jsonData
        
        //또는 -> URLSession.shared.rx.json(request: request)
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if 200 ... 399 ~= statusCode {//서버의 응답 결과 정의 후 다양하게 처리 가능..
                        observer.onNext(data ?? Data())
                    } else {
                        observer.onError(NetworkError.error(HTTPURLResponse.localizedString(forStatusCode: statusCode)))
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
