//
//  Helpers.swift
//  CoreDataList
//
//  Created by Jorge Armando Avila Estrada on 17/12/22.
//

import Foundation

func validateText(text : String) -> Bool{
    if (text.trimmingCharacters(in: .whitespaces).isEmpty){
        return false
    }
    else{
        return true
    }
}
