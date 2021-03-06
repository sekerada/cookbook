//
//  Network.swift
//  Cookbook-Test-Project
//
//  Created by Tomas Kohout on 1/26/16.
//  Copyright © 2016 Ackee s.r.o. All rights reserved.
//

import Foundation
import Alamofire
import Reqres
import RxSwift

struct NetworkError: Error {
    let error: NSError
    let request: URLRequest?
    let response: HTTPURLResponse?
}


protocol Networking {
    func request(_ url: String, method: Alamofire.HTTPMethod, parameters: [String: Any], encoding: ParameterEncoding, headers: [String:String]?) -> Observable<(Data?,NetworkError?)>
}


class Network: Networking {
    
    let alamofireManager : SessionManager
    
    init() {
        let configuration = Reqres.defaultSessionConfiguration()

        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        alamofireManager =  Alamofire.SessionManager(configuration: configuration)
    }

    func request(_ url: String, method: HTTPMethod, parameters: [String : Any], encoding: ParameterEncoding = URLEncoding.default, headers: [String : String]?) -> Observable<(Data?, NetworkError?)> {
        return Observable.create({ observer in
            self.alamofireManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON(completionHandler: {
                let data = $0.data, response = $0.response, error = $0.error, request = $0.request
                switch (data, error) {
                case (_, .some(let e)): observer.onNext((nil, NetworkError(error: e as NSError, request: request, response: response)))
                case (.some(let d), _): observer.onNext((d, nil))
                default: break
                }
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
}
