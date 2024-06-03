//
//  Prize.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 22.05.2024.
//

public enum Prize {
    case first, firstNB, second, third, fourth, fifth, threePre, threeSuf, twoSuf
    
    var stringPrize: String {
        switch self {
        case .first:
            "รางวัลที่ 1"
        case .firstNB:
            "รางวัลข้างเคียงรางวัลที่ 1"
        case .second:
            "รางวัลที่ 2"
        case .third:
            "รางวัลที่ 3"
        case .fourth:
            "รางวัลที่ 4"
        case .fifth:
            "รางวัลที่ 5"
        case .threePre:
            "รางวัลเลขหน้า 3 ตัว"
        case .threeSuf:
            "รางวัลเลขท้าย 3 ตัว"
        case .twoSuf:
            "รางวัลเลขท้าย 2 ตัว"
        }
    }
    
    var intPrize: Int {
        switch self {
        case .first:
            6_000_000
        case .firstNB:
            100_000
        case .second:
            2_000_000
        case .third:
            80_000
        case .fourth:
            40_000
        case .fifth:
            20_000
        case .threePre:
            4_000
        case .threeSuf:
            4_000
        case .twoSuf:
            2_000
        }
    }
}
