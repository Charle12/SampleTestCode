//
//  Result.swift
//  Sample
//
//  Created by Admin on 10/02/23.
//

import Foundation

//MARK:- Service enums
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
