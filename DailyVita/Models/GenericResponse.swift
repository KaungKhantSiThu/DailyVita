//
//  GenericResponse.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 14/11/2024.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let data: [T]
}
