//
//  ServiceProvider.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation

///API 프로바이더 관리 목적
final class ServiceProvider {
    static let shared = ServiceProvider()
    
    let github = GithubProvider()
}
