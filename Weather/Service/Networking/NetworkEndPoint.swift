//
//  NetworkEndPoint.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkEndPoint {
    func provideValues()-> (url: String, httpMethod: HTTPMethod, parameters:[String:Any]?,encoding: ParameterEncoding)
    var url: URLConvertible         { get }
    var httpMethod: HTTPMethod      { get }
    var parameters: [String: Any]?  { get }
    var encoding: ParameterEncoding { get }
}

extension NetworkEndPoint {
    var url: URLConvertible         { return provideValues().url }
    var httpMethod: HTTPMethod      { return provideValues().httpMethod }
    var parameters: [String: Any]?  { return provideValues().parameters }
    var encoding: ParameterEncoding { return provideValues().encoding }
}
