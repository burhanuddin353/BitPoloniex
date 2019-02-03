//
//  Network.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/3/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidParameters
}

class Network {

    static let shared = Network()

    private var reachabilityManager = NetworkReachabilityManager()
    var isReachable: Bool {
        return reachabilityManager?.isReachable ?? false
    }

    private func requestWith(url: URL, method: HTTPMethod = .get, parameters: Parameters = [:], completionHandler: @escaping (Result<[String: Any]>) -> ()) {

        var encoding: ParameterEncoding = URLEncoding.default
        if method == .post { encoding = JSONEncoding.default }
        request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { (response) in

            response.result.ifSuccess {

                if let value = response.result.value as? [String: Any] {
                    if let error = value["error"] as? String {
                        completionHandler(.failure(NSError(domain: "reqres.in", code: 400, userInfo: [NSLocalizedDescriptionKey: error])))
                    } else {
                        completionHandler(.success(value))
                    }
                }
            }

            response.result.ifFailure {
                completionHandler(.failure(NetworkError.invalidParameters))
            }
        }
    }

    func login(email: String, password: String, completionHandler: @escaping (Result<Bool>) -> ()) {

        let parameters: Parameters = ["email": email,
                                      "password": password]

        requestWith(url: URL(string: "https://reqres.in/api/login")!, method: .post, parameters: parameters) { (result) in

            result.ifSuccess {
                if let value = result.value, let _ = value["token"] as? String {
                    completionHandler(.success(true))
                } else {
                    completionHandler(.success(false))
                }
            }

            result.ifFailure {
                completionHandler(.success(false))
            }
        }
    }

    func register(email: String, password: String, completionHandler: @escaping (Result<Bool>) -> ()) {

        let parameters: Parameters = ["email": email,
                                      "password": password]

        requestWith(url: URL(string: "https://reqres.in/api/register")!, method: .post, parameters: parameters) { (result) in

            result.ifSuccess {
                if let value = result.value, let _ = value["token"] as? String {
                    completionHandler(.success(true))
                } else {
                    completionHandler(.success(false))
                }
            }

            result.ifFailure {
                completionHandler(.success(false))
            }
        }
    }
}
