//
//  GithubProvider.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import RxSwift

struct ResponseData: Codable {
    let data: ResultData
}

struct ResultData: Codable {
    let viewer: Viewer
}

struct Viewer: Codable {
    let login, name: String
}

final class GithubProvider: BaseProvider<GithubAPI> {
    
    //MARK: * Main Logic --------------------
    func viewer() -> Observable<Viewer> {
        return requestQl(api: .viewer)
            .debug()
            .map(ResponseData.self)
            .map { $0.data.viewer }
    }
    
    func signIn() -> Observable<Viewer> {
        return request(api: .signIn)
            .debug()
            .map(ResponseData.self)
            .map { $0.data.viewer }
    }
    
    func notifications() -> Observable<Notifications> {
        return request(api: .notifications)
            .debug()
            .map(Notifications.self)
    }
}

