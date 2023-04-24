//
//  NumberFactsPresenter.swift
//  NumberFacts
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import Foundation

protocol NumberFactsPresentationLogic: AnyObject {
    func present(state: NumberFactsModels.ScreenState)
}

class NumberFactsPresenter: NumberFactsPresentationLogic {
    
    // MARK: - Private Properties
    
    private weak var viewController: NumberFactsDisplayLogic?
    
    // MARK: - Init
    
    init(viewController: NumberFactsDisplayLogic) {
        self.viewController = viewController
    }
    
    // MARK: Public Methods
    
    func present(state: NumberFactsModels.ScreenState) {
        DispatchQueue.main.async {
            self.viewController?.present(state: state)
        }
    }
    
    // MARK: Private Methods
    
}
