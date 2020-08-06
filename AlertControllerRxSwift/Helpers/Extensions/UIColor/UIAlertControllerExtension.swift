//
//  UIAlertController.swift
//  AlertControllerRxSwift
//
//  Created by Сычев Евгений Дмитриевич on 28.07.2020.
//  Copyright © 2020 Сычев Евгений Дмитриевич. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - UIAlertControllerExtension

extension UIViewController {
    
   
    // MARK: - Public methods
    
    func callAlertBinding(title: String?, message: String, text: PublishSubject<String?>) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            alertController.textFields?.first?.rx.text.bind(to: text).disposed(by: DisposeBag())
        }
        
        alertController.addTextField { textField in
            textField.placeholder = message
        }
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func callAlert(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
}
