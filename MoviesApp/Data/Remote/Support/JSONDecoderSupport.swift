//
//  JSONDecoderSupport.swift
//  MoviesApp
//
//  Created by jorgehc on 9/9/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//
/// Simply allow to throw strings as Error
import Alamofire

extension String: Error {}

extension JSONDecoder {
    /// Reference: https://grokswift.com/decodable-with-alamofire-4/
    func decodeResponse<T: Decodable>(from response: DataResponse<Any>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure("Did not get data in response")
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            return .failure(error)
        }
    }
    
    func decodeError(from response: DataResponse<Any>) -> Result<ServerErrorModel> {
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure("Did not get data in response")
        }
        
        do {
            let error = try decode(ServerErrorModel.self, from: responseData)
            return .success(error)
        } catch {
            return .failure(error)
        }
    }
}
