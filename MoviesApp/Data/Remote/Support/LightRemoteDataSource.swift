//
//  LightRemoteDataSource.swift
//  MoviesApp
//
//  Created by jorgehc on 9/5/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation
import Alamofire
import ServerErrorModel

protocol LightRemoteDataSource {
    func serverRequest<Model: Decodable>(
        _ request: ServerRequest<Model>,
        _ errorHandler: HorrorHandler?
    )
}

public class ServerRequest<Model: Decodable> {
    public typealias CompletionHandler = (Model?, String?) -> Void
    
    public var completionHandler: CompletionHandler
    public var endPoint: URLRequestConvertible
    
    public init(endPoint: URLRequestConvertible, completionHandler: @escaping CompletionHandler) {
        self.endPoint = endPoint
        self.completionHandler = completionHandler
    }
}

//MARK: - Generic Request
extension LightRemoteDataSource {
    func serverRequest<Model: Decodable>(
        _ request: ServerRequest<Model>,
        _ errorHandler: HorrorHandler? = nil) {
        debugPrint("REQUEST")
        debugPrint(request.endPoint)
        Alamofire
            .request(request.endPoint)
            .responseJSON { response in
                debugPrint("RESPONSE")
                debugPrint(response)
                switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    if (200..<300).contains(response.response!.statusCode) {
                        request.completionHandler(nil, nil)
                    } else {
                        let errorData: Result<ServerErrorModel> = decoder.decodeError(from: response)
                        switch errorData {
                        case .failure(let error):
                            debugPrint(error.localizedDescription)
                        case .success(let errorModel):
                            if let serverError = ServerErrorCode(rawValue: errorModel.code) {
                                request.completionHandler(nil, serverError.rawValue)
                            }
                        }
                    }
                case .failure(let error):
                    debugPrint("Error on failure")
                    print(error)
                    if let err = error as? URLError, err.code  != URLError.Code.notConnectedToInternet {
                        request.completionHandler(nil, error.localizedDescription)
                    }
                }
        }
    }
}
