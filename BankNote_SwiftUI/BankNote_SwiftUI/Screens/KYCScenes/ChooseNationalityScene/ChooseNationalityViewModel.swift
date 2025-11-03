//
//  ChooseNationalityViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class ChooseNationalityViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol

    @Published var getKYCCibcResponse: GetKYCCibcUIModel?
    @Published var getNationalityResponse: GetNationalityUIModel?
        
    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?
    @Published var getNationalityAPIResult:APIResultType<GetNationalityUIModel>?

    @Published var selectNationalityItemPicker: ItemPickerModelType?
    private let tagNationality = 0

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

// MARK: Routing
extension ChooseNationalityViewModel {
    func openLoginInformationScene() {
        coordinator.openLoginInformationScene()
    }
    
    func openPickerNationality(){
        SceneDelegate.getAppCoordinator()?.openPickerItemsScene(allowSearch: true, tag:tagNationality,title: "nationality".localized, delegate: self, selectItem: selectNationalityItemPicker, list: getListNationality())
    }

}

// MARK: API Calls
extension ChooseNationalityViewModel {
    func getKYCCibcAPI(success: Bool, requestItems: [GetKYCCibcRequestItems]) {
        
        let requestModel = GetKYCCibcRequestModel(RequestItems: requestItems, reqID: KeyChainController().verifyPhoneOtpRequestId)
        
        getKYCCibcAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetKYCCibc(requestModel: requestModel) {[weak self] result in
                self?.getKYCCibcAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("getKYCCibc success")
                    
                    if success.ErrorCode == "0" || success.ErrorCode == ""  {
                        self?.getKYCCibcAPIResult = .onSuccess(response: success)
                        self?.getKYCCibcResponse = success
                        self?.openLoginInformationScene()
                    } else {
                        self?.getKYCCibcAPIResult = .onFailure(error: .custom(error: success.ErrorMessage ?? ""))
                    }
                  
                    
                    
                    
                case .failure(let failure):
                        debugPrint("getKYCCibc failed")
                        self?.getKYCCibcAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getNationalityAPI(success: Bool) {
        let requestModel = GetNationalityRequestModel(FormType: "1", Lang: AppUtility.shared.isRTL ? "ar" : "en")
        
        getNationalityAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetNationality(requestModel: requestModel) {[weak self] result in
                self?.getNationalityAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get nationality success")
                    
                    if success.resData.isEmpty == false {
                        self?.getNationalityAPIResult = .onSuccess(response: success)
                        self?.getNationalityResponse = success
                        
//                        self?.openPickerNationality()
                    } else {
                        self?.getNationalityAPIResult = .onFailure(error: .custom(error: success.ErrorMsg ?? ""))
                    }
                    
                    
                case .failure(let failure):
                        debugPrint("get nationality failed")
                        self?.getNationalityAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}

// MARK: Functions
extension ChooseNationalityViewModel {
    private func getListNationality() -> [ItemPickerUIModel]{
        var list:[ItemPickerUIModel] = []
        for i in 0..<(getNationalityResponse?.resData.count ?? 0) {
            list.append(.init(key: String(i), name: getNationalityResponse?.resData[i]?.NationalityName ?? "", id: getNationalityResponse?.resData[i]?.value ?? ""))
        }
        return list
    }

}


// MARK: Delegates
extension ChooseNationalityViewModel: PickerItemsDelegate{
    func onSelect(tag:Int,model:  ItemPickerModelType) {
        if tag == tagNationality{
            selectNationalityItemPicker = model
        }
    }
    
    func onSelectMulti(tag: Int, model: [any ItemPickerModelType]) {
        
    }

}

