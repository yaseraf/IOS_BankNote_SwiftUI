//
//  QuestioneerViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import UIKit
import Foundation
import SwiftUI
import MapKit

class QuestioneerViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getKycFieldAPIResult:APIResultType<GetKycFieldValifyUIModel>?
    @Published var getKycContractAPIResult:APIResultType<GetKycContractValifyUIModel>?
    @Published var getContractAPIResult:APIResultType<GetContractValifyUIModel>?
    
    @Published var kycFieldsData: GetKycFieldValifyUIModel?
    @Published var contractsData: GetKycContractValifyUIModel?
    @Published var selectContractsItemPicker: [ItemPickerModelType] = []
    
    @Published var kycFieldsValues: [String: String] = [:]
    @Published var contractURL: String = ""
    @Published var showContract: Bool = false
    
    private let tagInvestmentProduct = 2

    init(coordinator: AuthCoordinatorProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.valifyUseCase = valifyUseCase
        
        self.kycFieldsData = GetKycFieldValifyUIModel(data: [], errorCode: "", errorDescriptions: "", errorMessage: "")
    }
}

// MARK: Routing
extension QuestioneerViewModel {
    func openThanksForRegisteringScene() {
        coordinator.openThanksForRegisteringScene()
    }
    
    func openContractsScene() {
        SceneDelegate.getAppCoordinator()?.openPickerMultiItemsScene(tag: tagInvestmentProduct, title: "select_contracts".localized, delegate: self, selectItems: selectContractsItemPicker, list: getContracts())
    }
}

// MARK: Functions
extension QuestioneerViewModel {
    private func getContracts() -> [ItemPickerUIModel] {
        var list:[ItemPickerUIModel] = []
        for i in 0..<(contractsData?.data?.count ?? 0){
            list.append(.init(key: contractsData?.data?[i].contractVersion ?? "", name: contractsData?.data?[i].contractName ?? "", id: contractsData?.data?[i].id ?? ""))
        }
    return list
    }
}

// MARK: API Calls
extension QuestioneerViewModel {
    func getKycFieldValifyAPI(success: Bool) {
        
        let requestModel = GetKycFieldValifyRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
        
        getKycFieldAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.GetKYCFieldValify(requestModel: requestModel) {[weak self] result in
                self?.getKycFieldAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getKycFieldAPIResult = .onSuccess(response: success)
                    debugPrint("kyc field success")
                    
                    self?.kycFieldsData = success
                    
                    if success.data?.contains(where: { $0.isMandatory == "y" }) == true {
                    }
                    
                                        
                case .failure(let failure):
                        debugPrint("kyc field failed")
                        self?.getKycFieldAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getKycContractValifyAPI(success: Bool) {
        
        let requestModel = GetKycContractValifyRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
        
        getKycContractAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.GetKYCContractValify(requestModel: requestModel) {[weak self] result in
                self?.getKycContractAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getKycContractAPIResult = .onSuccess(response: success)
                    debugPrint("get kyc contract success")
                    
                    self?.contractsData = success
                    
                case .failure(let failure):
                        debugPrint("get kyc contract failed")
                        self?.getKycContractAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getContractValifyAPI(success: Bool) {
        
        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)

        
        let fields = kycFieldsValues.map { key, value in
            GetContractValifyFieldModel(
                fieldId: key,
                value: value
            )
        }
        
//        let requestModel = GetContractValifyRequestModel(crmNumber: "", fields: fields, lang: "", tenantId: "", token: "", userId: "", autofill: "", expiryMinutes: "", metadata: .none, reqID: KeyChainController().valifyRequestId ?? "", templateVersionId: "\(self.contractsData?.data?.first?.contractVersion)")
        
        let requestModel = GetContractValifyRequestModel(crmNumber: "", fields: fields, lang: "", tenantId: "", token: "", userId: "", autofill: "", expiryMinutes: "", metadata: GetContractValifyMetadataModel(deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "", deviceIp: UserDefaultController().userIPAddress ?? "", deviceType: "IOS", kycRefId: KeyChainController().valifyRequestId ?? "", latitude: latitude, longitude: longitude), reqID: KeyChainController().valifyRequestId ?? "", templateVersionId: selectContractsItemPicker.first?.key ?? "")
        
        getContractAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.GetContractValify(requestModel: requestModel) {[weak self] result in
                self?.getContractAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getContractAPIResult = .onSuccess(response: success)
                    debugPrint("get kyc contract success")
                    
                    if success.data?.isSuccessful == true {
                        guard let url = URL(string: success.data?.iframeUrl ?? "") else { return }
                        self?.contractURL = success.data?.iframeUrl ?? ""
                        self?.showContract = true

//                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.data?.errorMsg ?? "")
                    }
                    
                case .failure(let failure):
                        debugPrint("get kyc contract failed")
                        self?.getContractAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}

extension QuestioneerViewModel:PickerItemsDelegate {
    func onSelect(tag:Int,model:  ItemPickerModelType) {
    }
    
    func onSelectMulti(tag:Int,model:[ItemPickerModelType]) {
        if tag == tagInvestmentProduct {
            selectContractsItemPicker.removeAll()
            for item in model {
                if let index  = selectContractsItemPicker.firstIndex(where: { $0.id == item.id }) {
                } else {
                    selectContractsItemPicker.append(item)
                }
            }
        }
    }
}
