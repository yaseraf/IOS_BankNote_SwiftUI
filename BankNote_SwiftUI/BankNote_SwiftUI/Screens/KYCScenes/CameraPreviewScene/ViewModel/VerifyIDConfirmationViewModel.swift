//
//  CameraPreviewViewModel.swift
//  mahfazati
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
//import MLImage
//import MLKit

class VerifyIDConfirmationViewModel:ObservableObject{
    
    private let coordinator: AuthCoordinatorProtocol
    private let valifyUseCase: ValifyUseCaseProtocol
        
    @Published var getValifyDataAPIResult:APIResultType<GetValifyDataUIModel>?
    
    @Published var fullName: String = ""
    @Published var address: String = ""
    @Published var dateOfBith: String = ""
    @Published var idNumber: String = ""
    @Published var idKey: String = ""

    init(coordinator: AuthCoordinatorProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.valifyUseCase = valifyUseCase
    }
    
    func formatJsonDate(_ jsonDate: String) -> String {
        let pattern = #"\/Date\((\d+)([+-]\d+)?\)\/"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(jsonDate.startIndex..<jsonDate.endIndex, in: jsonDate)
        
        if let match = regex?.firstMatch(in: jsonDate, options: [], range: range),
           let millisRange = Range(match.range(at: 1), in: jsonDate) {
            
            let millisString = String(jsonDate[millisRange])
            if let millis = Double(millisString) {
                let date = Date(timeIntervalSince1970: millis / 1000)
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                formatter.locale = Locale.current
                return formatter.string(from: date)
            }
        }
        
        return "Invalid date"
    }
    
}

// MARK: Routing
extension VerifyIDConfirmationViewModel {
    func dismiss() {
        coordinator.popViewController()
    }
    
    func openLivenessCheckScene() {
        coordinator.openLivenessCheckScene()
    }

}

// MARK: API Calls
extension VerifyIDConfirmationViewModel {
    func getValifyDataAPI(success: Bool) {

        getValifyDataAPIResult = .onLoading(show: true)

        let requestModel = GetValifyDataRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
        
        Task.init {
            await valifyUseCase.GetValifyData(requestModel: requestModel) {[weak self] result in
                self?.getValifyDataAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("getValifyData success")
                    
                    if success.resData != nil {
                        
                        self?.getValifyDataAPIResult = .onSuccess(response: success)
                        self?.fullName = success.resData?.fullName ?? ""
                        self?.address = success.resData?.street ?? ""
                        self?.dateOfBith = success.resData?.dateOfBirth ?? ""
                        self?.idNumber = success.resData?.frontNid ?? ""
                        self?.idKey = success.resData?.backNid ?? ""

                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.errorMsg ?? "")
                    }
                    
                case .failure(let failure):
                    debugPrint("GetFrontBackValify failed")
                    self?.getValifyDataAPIResult = .onFailure(error: failure)
                    
                }
            }
        }
    }

}
