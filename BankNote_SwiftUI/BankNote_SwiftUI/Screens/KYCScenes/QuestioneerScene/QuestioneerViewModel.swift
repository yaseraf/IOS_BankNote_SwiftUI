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
    private let useCase: KYCUseCaseProtocol

    @Published var getKycFieldAPIResult:APIResultType<GetKycFieldValifyUIModel>?
    @Published var getKycContractAPIResult:APIResultType<GetKycContractValifyUIModel>?
    @Published var knfrmGetContractDetailsAPIResult:APIResultType<KnfrmGetContractDetailsUIModel>?
    @Published var getContractAPIResult:APIResultType<GetContractValifyUIModel>?
    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?
    @Published var getKYCDataByIdAPIResult:APIResultType<GetKYCDataByIDUIModel>?

    @Published var kycFieldsData: GetKycFieldValifyUIModel?
    @Published var contractsData: GetKycContractValifyUIModel?
    @Published var selectContractsItemPicker: [ItemPickerModelType] = []
    @Published var signedContractsItemPicker: [ItemPickerModelType] = []
    
    @Published var kycFieldsValues: [String: String] = [:]
    @Published var contractURL: String = ""
    @Published var contractId: String = ""
    @Published var showContract: Bool = false
    
    private let tagInvestmentProduct = 2

    init(coordinator: AuthCoordinatorProtocol, valifyUseCase: ValifyUseCaseProtocol, useCase: KYCUseCaseProtocol) {
        self.coordinator = coordinator
        self.valifyUseCase = valifyUseCase
        self.useCase = useCase
        
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
            if signedContractsItemPicker.contains(where: {$0.id == contractsData?.data?[i].id ?? ""}) == true {
                list.append(.init(key: "contract already exist", name: contractsData?.data?[i].contractName ?? "", id: contractsData?.data?[i].id ?? ""))
            } else {
                list.append(.init(key: contractsData?.data?[i].contractVersion ?? "", name: contractsData?.data?[i].contractName ?? "", id: contractsData?.data?[i].id ?? ""))
            }
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
    
    func getKYCCibcAPI(success: Bool, requestItems: [GetKYCCibcRequestItems]) {
        
        let requestModel = GetKYCCibcRequestModel(RequestItems: requestItems, reqID: KeyChainController().valifyRequestId)
        
        getKYCCibcAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetKYCCibc(requestModel: requestModel) {[weak self] result in
                self?.getKYCCibcAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    debugPrint("getKYCCibc success")
                    
                case .failure(let failure):
                        debugPrint("getKYCCibc failed")
                        self?.getKYCCibcAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func getKYCDataByIdAPI(success: Bool) {
        
        let requestModel = GetKYCDataByIDRequestModel(IDs: "285", USER_ID: "", req_ID: KeyChainController().valifyRequestId ?? "")
        
        getKYCDataByIdAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.GetKYCDataById(requestModel: requestModel) {[weak self] result in
                self?.getKYCDataByIdAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    debugPrint("getKYCCibc success")
                    
                    let dataContracts = success.resData?.filter({$0.ID == "285"}).first?.VALUE

                    if dataContracts?.isEmpty == false {
                        for item in self?.contractsData?.data ?? [] {
                            if dataContracts?.contains(item.id ?? "") == true {
                                self?.signedContractsItemPicker.append(ItemPickerUIModel(key: item.contractVersion ?? "", name: item.contractName ?? "", id: item.id ?? ""))
                            }
                        }
                    }

                    
                case .failure(let failure):
                        debugPrint("getKYCCibc failed")
                        self?.getKYCDataByIdAPIResult = .onFailure(error: failure)
               
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
        
        let requestModel = GetContractValifyRequestModel(crmNumber: "", fields: fields, lang: "", tenantId: "", token: "", userId: "", autofill: "", expiryMinutes: "", metadata: .init(deviceId: "", deviceIp: "", deviceType: "", kycRefId: "", latitude: "", longitude: "") /*GetContractValifyMetadataModel(deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "", deviceIp: UserDefaultController().userIPAddress ?? "", deviceType: "IOS", kycRefId: KeyChainController().valifyRequestId ?? "", latitude: latitude, longitude: longitude)*/, reqID: KeyChainController().valifyRequestId ?? "", templateVersionId: selectContractsItemPicker.first?.key ?? "")
        
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
                        self?.contractId = success.data?.contractId ?? ""

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
    
    func KnfrmGetContractDetailsAPI(success: Bool) {
        
        let requestModel = KnfrmGetContractDetailsRequestModel(RequestId: KeyChainController().valifyRequestId ?? "", Token: "", contract_id: contractId)
        
        knfrmGetContractDetailsAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.KnfrmGetContractDetails(requestModel: requestModel) {[weak self] result in
                self?.knfrmGetContractDetailsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.knfrmGetContractDetailsAPIResult = .onSuccess(response: success)
                    debugPrint("get kyc contract success")
                    
                    if success.data?.filter({$0.contract_id == self?.contractId}).first?.status?.lowercased() == "approved" {
                        self?.getKYCCibcAPI(success: true, requestItems: [GetKYCCibcRequestItems(ID: "285", Value: self?.contractId ?? "")])
                    }
                    
                case .failure(let failure):
                        debugPrint("get kyc contract failed")
                        self?.knfrmGetContractDetailsAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getKycDataByIdAPI(success: Bool) {
        
        let requestModel = KnfrmGetContractDetailsRequestModel(RequestId: KeyChainController().valifyRequestId ?? "", Token: "", contract_id: contractId)
        
        knfrmGetContractDetailsAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.KnfrmGetContractDetails(requestModel: requestModel) {[weak self] result in
                self?.knfrmGetContractDetailsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.knfrmGetContractDetailsAPIResult = .onSuccess(response: success)
                    debugPrint("get kyc contract success")
                    
                    if success.data?.filter({$0.contract_id == self?.contractId}).first?.status?.lowercased() == "approved" {
                        self?.getKYCCibcAPI(success: true, requestItems: [GetKYCCibcRequestItems(ID: "285", Value: self?.contractId ?? "")])
                    }
                    
                case .failure(let failure):
                        debugPrint("get kyc contract failed")
                        self?.knfrmGetContractDetailsAPIResult = .onFailure(error: failure)
               
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
