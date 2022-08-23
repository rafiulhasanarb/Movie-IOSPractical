//
//  CustomError.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import Foundation

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case errorCode(Int)
    case unknown
}
