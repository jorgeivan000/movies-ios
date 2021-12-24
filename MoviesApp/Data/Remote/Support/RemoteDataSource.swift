//
//  RemoteDataSource.swift
//  MoviesApp
//
//  Created by jorgehc on 11/24/17.
//  Copyright © 2017 jorgehc.com All rights reserved.
//

import Foundation
import Alamofire

enum SevereErrorCode: String {
    case IER4002 //Unauthorized user
    case IER4011 //Banned user
    case IER4016 //Incorrect user or password
    case IER4300 //Banned account
    case IER5030 //Maintenance mode
}

public class ServerRequest<Model: Decodable> {
    public typealias CompletionHandler = (Model?, String?) -> Void
    
    // no further changes
    public var completionHandler: CompletionHandler
    public var endPoint: URLRequestConvertible
    
    public init(endPoint: URLRequestConvertible, completionHandler: @escaping CompletionHandler) {
        self.endPoint = endPoint
        self.completionHandler = completionHandler
    }
}

protocol RemoteDataSource {
    func serverRequest<Model: Decodable>(
        _ request: ServerRequest<Model>,
        _ errorHandler: HorrorHandler?
    )
}

//MARK: - Generic Request
extension RemoteDataSource {
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
                    /* Status 204: No Content
                     Response is empty with no data, no decoding can be done
                     so handling differs.
                    */
                    if(204 == response.response!.statusCode){
                        self.handleNoDataSuccess(response, request)
                    } else if (200..<300).contains(response.response!.statusCode) {
                        self.handleTrueSuccess(response, request)
                    } else {
                        self.handleErrorOnSupposedSuccess(response, errorHandler, request)
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
    
    private func handleErrorOnSupposedSuccess<Model: Decodable>(
        _ response: DataResponse<Any>,
        _ errorHandler: HorrorHandler? = nil,
        _ request: ServerRequest<Model>) {
        
        //TODO: Handle error response
        debugPrint("Error on success")
        
        let statusCode = response.response!.statusCode
        let unauthorizedMessage = AuthenticationErrorHandler().horrorHandler(code: statusCode)
        guard unauthorizedMessage == nil else {
            let sessionManager = SessionManager()
            if unauthorizedMessage == String.bannedCodeMessage {
                let decoder = JSONDecoder()
                let errorData: Result<ServerErrorModel> = decoder.decodeError(from: response)
                switch errorData {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .success(let errorModel):
                    let errorMessage = decodeServerErrorMessage(errorModel)
                    request.completionHandler(nil, errorMessage)
                }
            } else if unauthorizedMessage == String.unauthorizedCodeMessage {
                let decoder = JSONDecoder()
                let errorData: Result<ServerErrorModel> = decoder.decodeError(from: response)
                var errorMessage: String = "401"
                switch errorData {
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                case .success(let errorModel):
                    errorMessage = decodeServerErrorMessage(errorModel)
                }
                request.completionHandler(nil, errorMessage)
            }
            return
        }
    
        let decoder = JSONDecoder()
        let errorData: Result<ServerErrorModel> = decoder.decodeError(from: response)
        switch errorData {
        case .failure(let error):
            request.completionHandler(nil, error.localizedDescription)
        case .success(let errorModel):
            let errorMessage = decodeServerErrorMessage(errorModel)
            request.completionHandler(nil, errorMessage)
        }
    }
    
    private func handleTrueSuccess<Model: Decodable>(
        _ response: DataResponse<Any>,
        _ request: ServerRequest<Model>) {
        
        let decoder = JSONDecoder()
        let data: Result<Model> = decoder.decodeResponse(from: response)
        switch data {
        case .failure(let error):
            request.completionHandler(nil, error.localizedDescription)
        default:
            request.completionHandler(data.value, nil)
        }
        
    }
    
    private func handleNoDataSuccess<Model: Decodable>(
        _ response: DataResponse<Any>,
        _ request: ServerRequest<Model>) {
        request.completionHandler(nil, nil)
    }
    
    private func decodeServerErrorMessage(_ errorModel: ServerErrorModel) -> String {
        if let serverError = ServerErrorCode(rawValue: errorModel.code) {
            switch serverError {
            default:
                return errorModel.message
            }
        }
        return errorModel.message
    }
}

