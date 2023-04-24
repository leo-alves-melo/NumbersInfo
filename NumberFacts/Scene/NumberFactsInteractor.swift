//
//  NumberFactsInteractor.swift
//  NumberFacts
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import Foundation

protocol NumberFactsLogic {
    func didTapRequestInfo(text: String?)
}

class NumberFactsInteractor: NumberFactsLogic {
    
    // MARK: - Private Properties
    
    private var presenter: NumberFactsPresentationLogic?
    private var worker: NumberFactsWorkerLogic?
    
    // MARK: - Init
    
    init(presenter: NumberFactsPresentationLogic, worker: NumberFactsWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: Public Methods
    
    func didTapRequestInfo(text: String?) {
        
        Task {
            
            do {
                self.presenter?.present(state: .loading)
                
                guard let worker else {
                    throw NumberFactsModels.ScreenErrors.unknownError
                }
                
                guard let text, let number = Int(text) else {
                    throw NumberFactsModels.ScreenErrors.invalidInput
                }
                
                let data = try await worker.requestInfo(number: number)
                
                guard let info = String(data: data, encoding: .utf8) else {
                    throw NumberFactsModels.ScreenErrors.unknownError
                }
                
                presenter?.present(state: .presenting(info: info))
                
            } catch {
                let error = error as? NumberFactsModels.ScreenErrors ?? .unknownError
                self.presenter?.present(state: .error(error: error))
            }
            
        }
    }
    
}
