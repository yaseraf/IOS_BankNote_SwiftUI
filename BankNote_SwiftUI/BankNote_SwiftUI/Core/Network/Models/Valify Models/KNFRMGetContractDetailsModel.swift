//
//  KNFRMGetContractDetailsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/02/2026.
//

import Foundation

// MARK: - Request Model
struct KnfrmGetContractDetailsRequestModel: Encodable {
    let RequestId: String?
    let Token: String?
    let contract_id: String?
}

// MARK: - Response Model
struct KnfrmGetContractDetailsResponseModel: Decodable {
    let data: [KnfrmGetContractDetailsDataModel]?
    let meta: KnfrmGetContractDetailsMetaModel?
    let pagination: KnfrmGetContractDetailsPaginationModel?
}

// MARK: - Data
struct KnfrmGetContractDetailsDataModel: Decodable {
    let contract_id: String?
    let created_at: String?
    let customers: [KnfrmGetContractCustomerModel]?
    let document_url: String?
    let expires_at: String?
    let fields: [KnfrmGetContractFieldModel]?
    let pdf_url: String?
    let preview_url: String?
    let signing_url: String?
    let status: String?
    let template_version_id: String?
    let updated_at: String?
}

// MARK: - Customer
struct KnfrmGetContractCustomerModel: Decodable {
    let email: String?
    let full_name: String?
    let id: String?
    let national_id: String?
    let phone: String?
}

// MARK: - Field
struct KnfrmGetContractFieldModel: Decodable {
    let field_id: String?
    let key: String?
    let label: String?
    let value: String?
}

// MARK: - Meta
struct KnfrmGetContractDetailsMetaModel: Decodable {
    let code: String?
    let errors: [KnfrmGetContractDetailsErrorModel]?
}

// MARK: - Error
struct KnfrmGetContractDetailsErrorModel: Decodable {
    let message: String?
    let severity: String?
    let type: String?
}

// MARK: - Pagination
struct KnfrmGetContractDetailsPaginationModel: Decodable {
    let current_page: String?
    let last_page: String?
    let per_page: String?
    let total: String?
}

struct KnfrmGetContractDetailsUIModel {
    var data: [KnfrmGetContractDetailsDataModel]?
    var errorCode: String?
    var errorDescriptions: String?
    var errorMessage: String?
    
    static func mapToUIModel(_ model: KnfrmGetContractDetailsResponseModel) -> Self {
        return KnfrmGetContractDetailsUIModel(
            data: model.data,
            errorCode: model.meta?.code,
            errorDescriptions: model.meta?.errors?.first?.type,
            errorMessage: model.meta?.errors?.first?.message
        )
    }
    
    static func initializer() -> Self {
        return KnfrmGetContractDetailsUIModel()
    }
}
