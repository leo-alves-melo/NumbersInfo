//
//  NumberFactsViewController.swift
//  NumberFacts
//
//  Created by Leonardo Alves de Melo on 24/04/23.
//

import UIKit

protocol NumberFactsDisplayLogic: AnyObject {
    func present(state: NumberFactsModels.ScreenState)
}

class NumberFactsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberInfoLabel: UILabel!
    @IBOutlet weak var numbersActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var getInfoButton: UIButton!
    
    // MARK: - Private Properties
    
    private var interactor: NumberFactsLogic?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numbersActivityIndicator.isHidden = true
        
        numberTextField.accessibilityIdentifier = "NumberFactsViewController-numberTextField"
        numberInfoLabel.accessibilityIdentifier = "NumberFactsViewController-numberInfoLabel"
        numbersActivityIndicator.accessibilityIdentifier = "NumberFactsViewController-numbersActivityIndicator"
        errorLabel.accessibilityIdentifier = "NumberFactsViewController-errorLabel"
        getInfoButton.accessibilityIdentifier = "NumberFactsViewController-getInfoButton"
    }
    
    // MARK: - Public Methods
    
    func setupArchitecture(interactor: NumberFactsLogic) {
        self.interactor = interactor
    }
    
    // MARK: - Private Methods
    
    @IBAction private func didTapGetInfo(_ sender: Any) {
        interactor?.didTapRequestInfo(text: numberTextField.text)
    }
}

extension NumberFactsViewController: NumberFactsDisplayLogic {
    func present(state: NumberFactsModels.ScreenState) {
        switch state {
        case .loading:
            numbersActivityIndicator.startAnimating()
            numbersActivityIndicator.isHidden = false
            errorLabel.text = ""
            numberInfoLabel.text = ""
        case .presenting(let info):
            numbersActivityIndicator.stopAnimating()
            numbersActivityIndicator.isHidden = true
            numberInfoLabel.text = info
            errorLabel.text = ""
        case .error(let error):
            numbersActivityIndicator.stopAnimating()
            numbersActivityIndicator.isHidden = true
            errorLabel.text = error.description
        }
    }
}
