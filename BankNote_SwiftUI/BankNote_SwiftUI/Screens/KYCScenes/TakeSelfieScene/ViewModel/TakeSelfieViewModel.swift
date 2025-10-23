//
//  TakeSelfieViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 07/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
class TakeSelfieViewModel:ObservableObject{
    private let coordinator: AuthCoordinatorProtocol
    @Published var isLivenessCheck:Bool
    init(coordinator: AuthCoordinatorProtocol,isLivenessCheck:Bool) {
        self.coordinator = coordinator
        self.isLivenessCheck = isLivenessCheck
    }
}

extension TakeSelfieViewModel{
    func openCameraPreviewForTakeSelfieScene(){
        coordinator.openCameraPreviewFor(type: .selfieMode(liveness: isLivenessCheck), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
    }

}
