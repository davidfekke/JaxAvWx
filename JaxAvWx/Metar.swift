//
//  Metar.swift
//  JaxAvWx
//
//  Created by David Fekke on 10/12/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Welcome
struct Metar: Codable {
    let reports: [Report]
}

// MARK: - Report
struct Report: Codable {
    let rawText, stationID: String
    let observationTime: String
    let latitude, longitude, tempC, dewpointC: Double
    let windDirDegrees, windSpeedKt, visibilityStatuteMi: Int
    let altimInHg: Double
    let seaLevelPressureMB: Double?
    //let qualityControlFlags: QualityControlFlags
    let skyCondition: Either<SkyCondition, [SkyCondition]>?
    let flightCategory: String
    let metarType: String
    let elevationM: Int
    let name: String?
    let distanceFrom, bearingTo: Int?

    enum CodingKeys: String, CodingKey {
        case rawText = "raw_text"
        case stationID = "station_id"
        case observationTime = "observation_time"
        case latitude, longitude
        case tempC = "temp_c"
        case dewpointC = "dewpoint_c"
        case windDirDegrees = "wind_dir_degrees"
        case windSpeedKt = "wind_speed_kt"
        case visibilityStatuteMi = "visibility_statute_mi"
        case altimInHg = "altim_in_hg"
        case seaLevelPressureMB = "sea_level_pressure_mb"
        //case qualityControlFlags = "quality_control_flags"
        case skyCondition = "sky_condition"
        case flightCategory = "flight_category"
        case metarType = "metar_type"
        case elevationM = "elevation_m"
        case name, distanceFrom, bearingTo
    }
}

// MARK: - QualityControlFlags
struct QualityControlFlags: Codable {
    let autoStation, maintenanceIndicatorOn: Bool

    enum CodingKeys: String, CodingKey {
        case autoStation = "auto_station"
        case maintenanceIndicatorOn = "maintenance_indicator_on"
    }
}

// MARK: - SkyCondition
struct SkyCondition: Codable {
    let skyCover: String
    let cloudBaseFtAgl: String?

    enum CodingKeys: String, CodingKey {
        case skyCover = "sky_cover"
        case cloudBaseFtAgl = "cloud_base_ft_agl"
    }
}

//
enum Either<L, R> {
    case left(L)
    case right(R)
}

extension Either: Decodable where L: Decodable, R: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let left = try? container.decode(L.self) {
            self = .left(left)
        } else if let right = try? container.decode(R.self) {
            self = .right(right)
        } else {
            throw DecodingError.typeMismatch(Either<L, R>.self, .init(codingPath: decoder.codingPath, debugDescription: "Expected either `\(L.self)` or `\(R.self)`"))
        }
    }
}

extension Either: Encodable where L: Encodable, R: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .left(left):
            try container.encode(left)
        case let .right(right):
            try container.encode(right)
        }
    }
}
