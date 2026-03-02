//
//  TiersViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class TiersViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol

    @Published var getTiersAPIResult:APIResultType<GetTiersUIModel>?

    @Published var tiersData: GetTiersUIModel = .initializer()
    @Published var tiers: [Tier] = []

    init(coordinator: SettingsCoordinatorProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension TiersViewModel {
    func callGetTiersAPI(success:Bool) {
        let requestModel = GetTiersRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getTiersAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetTiers(requestModel: requestModel) {[weak self] result in
                self?.getTiersAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getTiersAPIResult = .onSuccess(response: success)
                    debugPrint("get tiers success")
                    self?.tiersData = success
                    
                    for item in self?.tiersData.data ?? [] {
                        self?.tiers.append(
                            Tier(
                                nameKey: (AppUtility.shared.isRTL ? item.arabicDescription : item.englishDescription) ?? "",
                                imageName: "ic_rookie",
                                descriptionKeys: [],
                                howToBecomeKeys: [],
                                benefitKeys: [item.notes ?? ""]
                            )
                        )
                    }

                    
                case .failure(let failure):
                        self?.getTiersAPIResult = .onFailure(error: failure)
                    debugPrint("get tiers failed")
                }
            }
        }
    }
}
