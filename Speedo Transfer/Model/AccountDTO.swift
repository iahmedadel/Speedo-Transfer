//
//  AccountDTO.swift
//  Speedo Transfer
//
//  Created by MacBook Pro on 07/08/2024.
//

import Foundation




struct AccountDTO: Codable {
    var id: Int
    var username: String
    var email: String
    var phoneNumber: String
    var country: String
    var gender: String
    var dateOfBirth: String
    var cards: [CardDTO]

}
