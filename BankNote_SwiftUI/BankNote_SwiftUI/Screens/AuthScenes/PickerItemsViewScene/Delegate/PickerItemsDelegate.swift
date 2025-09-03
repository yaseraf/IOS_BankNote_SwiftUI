//
//  PickerItemsDelegate.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//
import Foundation
protocol PickerItemsDelegate{
    func onSelect(tag:Int,model:ItemPickerModelType)
    func onSelectMulti(tag:Int,model:[ItemPickerModelType])
}
