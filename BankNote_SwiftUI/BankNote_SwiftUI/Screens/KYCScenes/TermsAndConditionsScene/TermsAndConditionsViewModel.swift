//
//  TakeSelfieViewModel.swift
//  mahfazati
//
//  Created by FIT on 07/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import MapKit

class TermsAndConditionsViewModel:ObservableObject{
//    private let coordinator: CreateAccountCoordinatorProtocol
    private let coordinator: AuthCoordinatorProtocol
//    private let delegate:PickerItemsDelegate
    private let kycUseCase: KYCUseCaseProtocol

    @Published var selectSourceOfFundsItemPicker: ItemPickerModelType?
    @Published var selectListInvestmentObjectiveItemPicker: [ItemPickerModelType] = []
    @Published var selectListInvestmentProductItemPicker: [ItemPickerModelType] = []
    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?
    @Published var getSourceOfIncomeAPIResult:APIResultType<GetSourceOfIncomeUIModel>?
    @Published var getInvestObjectiveAPIResult:APIResultType<GetInvestObjectiveUIModel>?
    @Published var createBusinessRequestAPIResult:APIResultType<CreateBusinessRequestUIModel>?
    @Published var loginAdminAPIResult:APIResultType<LoginAdminUIModel>?
    @Published var approveOrRejectAPIResult:APIResultType<ApproveOrRejectRequestUIModel>?
    @Published var getCurrentBusinessRequestListAPIResult:APIResultType<GetCurrentBusinessRequestListUIModel>?

    @Published var getKYCCibcResponse: GetKYCCibcUIModel?
    @Published var getSourceOfIncomeResponse: GetSourceOfIncomeUIModel?
    @Published var getInvestObjectiveResponse: GetInvestObjectiveUIModel?

    private var listInvestmentObjectiveItemPicker: [ItemPickerModelType] = []
    
    var tag:Int = 0
    private let tagSourceOfFunds = 0
    private let tagInvestmentObjective = 1
    @Published var maxCount:Int = 0
    @Published var list:[ItemPickerModelType] = []
    @Published var selectItem:ItemPickerModelType?
    @Published var selectItems:[ItemPickerModelType] = []
    @Published var selectType:PickerItemsSelectType = .multi
    
    @Published var htmlContent: String = ""
    
    @Published var requestIDVLensID: String = ""
    
//    init(coordinator: CreateAccountCoordinatorProtocol) {
    init(coordinator: AuthCoordinatorProtocol, KYCUseCase: KYCUseCaseProtocol) {
        self.coordinator = coordinator
//        self.delegate = delegate
        self.kycUseCase = KYCUseCase

    }
    
    func createBusinessRequestAPI(success: Bool, requestFieldsValues: [CreateBusinessRequestFieldsValue]) {
        
        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)
        
        
        
       



        
        let requestModel = CreateBusinessRequestRequestModel(requestID: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken, geoLocation: CreateBusinessGeoLocation(latitude: latitude, longitude: longitude), requestFieldsValues: CreateBusinessRequestFieldsValue(key: "", value: ""), typeID: UserDefaultController().investmentProductKeys?.first)
        
        getInvestObjectiveAPIResult = .onLoading(show: true)
        
        //Signed - Customer signed - Request status

        Task.init {
            await kycUseCase.CreateBusinessRequest(requestModel: requestModel) {[weak self] result in
                self?.createBusinessRequestAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get create business success")
                    
                    self?.loginAdminAPI(success: true, id: success.data?.id ?? "", requestNumber: success.data?.requestNumber ?? "")
                    
                    self?.requestIDVLensID = success.data?.id ?? ""
                    
                case .failure(let failure):
                        debugPrint("get create business failed")
                        self?.createBusinessRequestAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func loginAdminAPI(success: Bool, id:String, requestNumber:String) {
        let requestModel = LoginAdminRequestModel()
        
        loginAdminAPIResult = .onLoading(show: true)

        Task.init {
            await kycUseCase.LoginAdmin(requestModel: requestModel) {[weak self] result in
                self?.loginAdminAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get login admin success")
                    
                    self?.approveOrRejectAPI(success: true, id: id, requestNumber: requestNumber, accessToken: success.data?.accessToken ?? "")
                    
                case .failure(let failure):
                    debugPrint("get login admin failure")
                        self?.loginAdminAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func approveOrRejectAPI(success: Bool, id:String, requestNumber:String, accessToken:String) {
        let requestModel = ApproveOrRejectRequestRequestModel(accessToken: accessToken, id: id, isApproved: true, requestID: KeyChainController().verifyPhoneOtpRequestId, requestNumber: requestNumber, requestFields: [])
        
        approveOrRejectAPIResult = .onLoading(show: true)

        Task.init {
            await kycUseCase.ApproveOrRejectRequest(requestModel: requestModel) {[weak self] result in
                self?.approveOrRejectAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get approve or reject success")
                    
                    // get the list
                    if success.data == true {
                        self?.getCurrentBusinessRequestListAPI(success: true)
                    }
                    
                case .failure(let failure):
                    debugPrint("get approve or reject failure")
                        self?.approveOrRejectAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func getCurrentBusinessRequestListAPI(success: Bool) {
        let requestModel = GetCurrentBusinessRequestListRequestModel(requestID: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken)
        
        getCurrentBusinessRequestListAPIResult = .onLoading(show: true)

        Task.init {
            await kycUseCase.GetCurrentBusinessRequestList(requestModel: requestModel) {[weak self] result in
                self?.getCurrentBusinessRequestListAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get current business success")
                    
                    self?.htmlContent = success.data?.generalTC ?? ""

                case .failure(let failure):
                        debugPrint("get current business failed")
                        self?.getCurrentBusinessRequestListAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func activateBusinessRequestAPI(success: Bool) {
        
        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)
        
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        
        let requestModel = ActivateBusinessRequestRequestModel(accessToken: KeyChainController().stepCreateAccessToken, geoLocation: ActivateBusinessGeoLocation(latitude: latitude, longitude: longitude), requestID: KeyChainController().verifyPhoneOtpRequestId, requestIDVlens: requestIDVLensID, userDeviceUTCTime: formatter.string(from: Date()))
        getCurrentBusinessRequestListAPIResult = .onLoading(show: true)

        Task.init {
            await kycUseCase.ActivateBusinessRequest(requestModel: requestModel) {[weak self] result in
                self?.getCurrentBusinessRequestListAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("get activate business success")
                    
                    if success.errorCode == "-1" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.errorMessage ?? "")
                    } else {
                        self?.coordinator.openVerifySignUpScene(verificationType: .email, phone: KeyChainController.shared().phoneNumberEntered ?? "", email: KeyChainController.shared().savedUserEmail ?? "", otpExpirationTimer: 0, otpRequestID: success.data?.otpRequestID ?? "", transactionID: success.data?.transactionID ?? "", requestIDVlens: self?.requestIDVLensID ?? "", isVlens: true)

//                        coordinator.openVerifySignUpScene(uiModel: VerifyOTPUIModel.init(viewType: .phoneNumber, value: KeyChainController.shared().phoneNumberEntered ?? ""), verifyWithEmail: false, phoneNumber: KeyChainController.shared().phoneNumberEntered ?? "", email: "", otpExpirationTimer: 0, otpRequestID: success.data?.otpRequestID ?? "", transactionID: success.data?.transactionID ?? "", requestIDVlens: self?.requestIDVLensID ?? "", isVlens: true)
                    }
                    
                                        

                case .failure(let failure):
                    debugPrint("get activate business failed")
                        self?.getCurrentBusinessRequestListAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    
    func selectItem(_ item:ItemPickerModelType) {
        if selectType == .multi{
            if let index  = selectItems.firstIndex(where: { $0.id == item.id }){
                selectItems.remove(at: index)
            }else{
                selectItems.append(item)
            }
        }
        
//        delegate.onSelect(tag: tag,model: item)
//        dissmiss()
    }

    private func getListSourceOfFunds() -> [ItemPickerUIModel]{
        var list:[ItemPickerUIModel] = []
        for i in 0..<(getSourceOfIncomeResponse?.resData.count ?? 0){
            list.append(.init(name: getSourceOfIncomeResponse?.resData[i]?.SourceOfIncome ?? "", id: getSourceOfIncomeResponse?.resData[i]?.value ?? ""))
        }
        return list
    }

    private func getListInvestmentObjective() -> [ItemPickerUIModel]{
        var list:[ItemPickerUIModel] = []
        for i in 0..<(getInvestObjectiveResponse?.resData.count ?? 0){
            list.append(.init(name: getInvestObjectiveResponse?.resData[i]?.Objective ?? "", id: getInvestObjectiveResponse?.resData[i]?.value ?? ""))
        }
    return list
    }
}

extension TermsAndConditionsViewModel{
    func openThanksForRegisteringScene(){
        coordinator.openThanksForRegisteringScene()
    }

    func openPickerSourceOfFunds(){
//        SceneDelegate.getAppCoordinator()?.openPickerItemsScene(allowSearch: true, tag:tagSourceOfFunds,title: "source_of_funds".localized, delegate: self, selectItem: selectSourceOfFundsItemPicker, list: getListSourceOfFunds())
    }
    func openInvestmentObjective(){

//        SceneDelegate.getAppCoordinator()?.openPickerMultiItemsScene(tag: tagInvestmentObjective, title: "investment_objective".localized, delegate: self, selectItems: selectListInvestmentObjectiveItemPicker, list: getListInvestmentObjective())


    }
    
    func openTermsAndConditionsScene() {
        coordinator.openTermsAndConditionsScene()
    }

}


extension TermsAndConditionsViewModel:PickerItemsDelegate{
    func onSelectMulti(tag: Int, model: [any ItemPickerModelType]) {
        
    }
    
    func onSelect(tag:Int,model:  ItemPickerModelType) {
        if tag == tagSourceOfFunds{
            selectSourceOfFundsItemPicker = model
        }else {

            if let index  = selectListInvestmentObjectiveItemPicker.firstIndex(where: { $0.id == model.id }){
                selectListInvestmentObjectiveItemPicker.remove(at: index)
            }else{
                selectListInvestmentObjectiveItemPicker.append(model)
            }
        }
    }



}

extension TermsAndConditionsViewModel{
    func dissmiss() {
        SceneDelegate.getAppCoordinator()?.dismiss()
    }
}
