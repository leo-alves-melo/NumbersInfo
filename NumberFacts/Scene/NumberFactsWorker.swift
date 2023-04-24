//
//  NumberFactsWorker.swift
//  NumberFacts
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import Foundation

protocol NumberFactsWorkerLogic {
    func requestInfo(number: Int) async throws -> Data
}

class NumberFactsWorker: NSObject, NumberFactsWorkerLogic {
    func requestInfo(number: Int) async throws -> Data {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.path = "/\(number)"
        urlComponents.host = "numbersapi.com"
        
        guard let url = urlComponents.url else {
            throw NumberFactsModels.ScreenErrors.failedToCreateUrlComponents
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        guard let (data, _) = try? await session.data(for: request) else {
            throw NumberFactsModels.ScreenErrors.notFound
        }
        
        return data
    }
}

extension NumberFactsWorker: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else { return }
        completionHandler(.useCredential, URLCredential(trust: serverTrust))
    }
}
