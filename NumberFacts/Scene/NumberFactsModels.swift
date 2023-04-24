//
//  NumberFactsModels.swift
//  NumberFacts
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import Foundation

struct NumberFactsModels {
    enum ScreenState {
        case loading
        case presenting(info: String)
        case error(error: ScreenErrors)
    }
    
    enum ScreenErrors: Error {
        case failedToCreateUrlComponents
        case notFound
        case invalidInput
        case unknownError
        
        var description: String {
            switch self {
            case .failedToCreateUrlComponents:
                return "Error to request"
            case .notFound:
                return "API not found"
            case .invalidInput:
                return "The input is not a number"
            case .unknownError:
                return "Unknown error"
            }
        }
    }
}
