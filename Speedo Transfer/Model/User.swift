//
//  User.swift
//  Speedo Transfer
//

import Foundation
struct CardDTO: Codable {
    var cardNumber: String
    var cardHolderName: String
    var expirationDate: String
    var cvv: String
}
struct UserRegistrationRequest: Codable {
    var username: String
    var email: String
    var address: String
    var country: String
    var gender: String
    var phoneNumber: String
    var dateOfBirth: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case address
        case country
        case gender
        case phoneNumber
        case dateOfBirth
        case password
        
    }
}
