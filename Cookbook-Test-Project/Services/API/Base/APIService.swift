//
//  APIService.swift
//  Cookbook-Test-Project
//
//  Created by Tomas Kohout on 4/12/16.
//  Copyright © 2016 Ackee s.r.o. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


enum RequestError: Error {
    case network(NetworkError)
    case mapping()
}

/// Base class which all API Services should inherit
class APIService {
    // MARK: Dependencies

    let network: Networking

    init(network: Networking) {
        self.network = network
    }

    func resourceURL(for path: String) -> URL {
        let URL = Foundation.URL(string: "")!
        let relativeURL = Foundation.URL(string: path, relativeTo: URL)!
        return relativeURL
    }

    // MARK: Requests API
    func request(_ path: String, method: Alamofire.HTTPMethod = .get, parameters: [String: Any] = [:], encoding: ParameterEncoding = URLEncoding.default, headers: [String: String] = [:]) -> Observable<(Data?, NetworkError?)> {
        let resourceURL = self.resourceURL(for: path)

        return network.request(resourceURL.absoluteString, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
