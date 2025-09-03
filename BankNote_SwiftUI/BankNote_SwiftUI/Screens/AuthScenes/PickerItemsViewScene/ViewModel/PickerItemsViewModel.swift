//
//  PickerItemsViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
class PickerItemsViewModel:ObservableObject{
    private let delegate:PickerItemsDelegate
    @Published var selectItem:ItemPickerModelType?
    @Published var selectItems:[ItemPickerModelType] = []
    var tag:Int
    var allowSearch:Bool
    @Published var title:String
    @Published var maxCount:Int = 0
    @Published var list:[ItemPickerModelType]
    @Published var listSearchResult:[ItemPickerModelType]? = []
    var originalList:[ItemPickerModelType]
    @Published var selectType:PickerItemsSelectType = .one

    init(allowSearch:Bool, selectType:PickerItemsSelectType,tag:Int,title:String,delegate: PickerItemsDelegate,selectItem:ItemPickerModelType?,selectItems:[ItemPickerModelType] = [],list:[ItemPickerModelType]) {
        self.allowSearch = allowSearch
        self.selectType = selectType
        self.selectItems = selectItems
        self.tag = tag
        self.title = title
        self.delegate = delegate
        self.selectItem = selectItem
        self.list = list
        self.originalList = list
        self.maxCount = originalList.count
    }
        

    func selectItem(_ item:ItemPickerModelType) {
        if selectType == .multi{
            if let index  = selectItems.firstIndex(where: { $0.id == item.id }){
                selectItems.remove(at: index)
            }else{
                selectItems.append(item)
            }
        } else {
            delegate.onSelect(tag: tag,model: item)
            dissmiss()
        }
        
//        delegate.onSelect(tag: tag,model: item)
//        dissmiss()
    }

    func searchName(name:String) {
       var filteredList = list.filter({
            $0.name.lowercased().contains(name.lowercased()) || $0.subName.lowercased().contains(name.lowercased())
        })
        if filteredList.isEmpty{
            filteredList = []
        }
        self.listSearchResult =  filteredList
    }
}

extension PickerItemsViewModel{
    func dissmiss() {
        SceneDelegate.getAppCoordinator()?.dismiss()
    }
    
    func dismissActions() {
        delegate.onSelectMulti(tag: tag,model: selectItems)
    }
}
