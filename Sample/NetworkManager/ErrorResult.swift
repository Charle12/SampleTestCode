//
//  ErrorResult.swift
//  Sample
//
//  Created by Admin on 10/02/23.
//

import Foundation

//MARK:- Service enums
enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
