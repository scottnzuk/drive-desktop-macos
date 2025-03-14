//
//  ProductsManager.swift
//  InternxtDesktop
//
//  Created by Patricio Tovar on 14/3/25.
//

import Foundation
import InternxtSwiftCore

class ProductsManager: ObservableObject {
    
    @Published var showAntivirus: Bool = false
    @Published var showBackups: Bool = false
    
    
    @MainActor
    func getProductStatus() async {
        do {
            
            let paymentInfo = try await APIFactory.Payment.getPaymentInfo(debug: true)
        }
        catch {
            
            guard let apiError = error as? APIClientError else {
                appLogger.info(error.getErrorDescription())
                return
            }
        }
    }
}
