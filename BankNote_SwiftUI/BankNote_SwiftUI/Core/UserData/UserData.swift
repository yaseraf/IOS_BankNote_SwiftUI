//
//  UserData.swift
//  mahfazati
//
//  Created by FIT on 03/10/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class UserData {
    
    static let shared = UserData()

    let container: NSPersistentContainer
    @Published var savedEntities: [UserEntity] = []
    @Published var savedCompaniesEntity: [CompanyEntity] = []
    @Published var locManager = CLLocationManager()

    
    init() {
        container = NSPersistentContainer(name: "UserContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("Error Loading Data: \(error)")
            }
        }
        
        getUsers()
        getCompanies()
    }
    
    // MARK: Users
    func getUsers() {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching: \(error)")
        }
        
    }
    
    func addUser(userWithSelection: String) {
        
        let newUser = UserEntity(context: container.viewContext)
        newUser.userWithSelection = userWithSelection
        saveData()
    }
    
    func editUser(userWithSelection: String, newSelection: String) {
        for item in UserData.shared.savedEntities {
            if (item.userWithSelection == userWithSelection) {
                item.userWithSelection = newSelection
                saveData()
                break
            }
        }
    }
    
    func deleteUser() {
        for item in savedEntities {
            container.viewContext.delete(item)
        }
        saveData()
    }
    
    // MARK: Companies
    func getCompanies() {
        let request = NSFetchRequest<CompanyEntity>(entityName: "CompanyEntity")
        
        do {
            savedCompaniesEntity = try container.viewContext.fetch(request)
        } catch let error {
            debugPrint("Error fetching: \(error)")
        }
        
    }
    
    func saveCompanies(newCompanies: [GetCompaniesLookupsUIModel]) {
        deleteAllCompanies(newCompanies: newCompanies)
    }

    func deleteAllCompanies(newCompanies: [GetCompaniesLookupsUIModel]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CompanyEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
            try container.viewContext.save()
            
            for company in newCompanies {
                    let entity = CompanyEntity(context: container.viewContext)
                    
                    entity.aboutDescA = company.aboutDescA
                    entity.aboutDescE = company.aboutDescE
                    entity.allowdBuyLimit = company.allowdBuyLimit
                    entity.allowShortSell = company.allowShortSell
                    entity.companyA = company.companyA
                    entity.companyE = company.companyE
                    entity.currCode = company.currCode
                    entity.exchange = company.exchange
                    entity.ipoValidityDate = company.ipoValidityDate
                    entity.isCryptoSymbol = company.isCryptoSymbol
                    entity.isDerivative = company.isDerivative
                    entity.isFund = company.isFund
                    entity.isIPOQuickSell = company.isIPOQuickSell
                    entity.isMargin = company.isMargin
                    entity.isUsOnline = company.isUsOnline
                    entity.isValidateMinMax = company.isValidateMinMax
                    entity.isinCode = company.isinCode
                    entity.lastDay = company.lastDay
                    entity.marketType = company.marketType
                    entity.precision = company.precision
                    entity.shortNameA = company.shortNameA
                    entity.shortNameE = company.shortNameE
                    entity.symbol = company.symbol
                    entity.symbolCompanyA = company.symbolCompanyA
                    entity.symbolCompanyDesc = company.symbolCompanyDesc
                    entity.symbolCompanyE = company.symbolCompanyE
                    entity.symbolID = company.symbolID
                    entity.templateMargin = company.templateMargin
                }
                
                saveData()

            print("✅ All companies deleted with batch request")
        } catch {
            print("❌ Failed to batch delete companies: \(error.localizedDescription)")
        }
    }


    
    func saveData() {
        do {
            try container.viewContext.save()
            getUsers()
            getCompanies()
        } catch let error {
            debugPrint("Error saving \(error)")
        }
    }
    
}
