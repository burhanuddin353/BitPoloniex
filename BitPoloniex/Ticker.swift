//
//  Ticker.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/3/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import Foundation

enum TickerError: Error {
    case invalidResponse
}

struct CurrencyPair {
    var id: Int
    var pair: String
}

class Ticker {

    var currencyPairID: Int
    var lastTradePrice: Double
    var lowestAsk: Double
    var highestBid: Double
    var percentageChangeLast24Hrs: Double
    var baseCurrencyVolumeLast24Hrs: Double
    var quoteCurrencyVolumeLast24Hrs: Double
    var isFrozen: Bool
    var highestTradePriceLast24Hrs: Double
    var lowestTradePriceLast24Hrs: Double

    init(response: [Any]) throws {

        guard let currencyPairID = response[0] as? Int else { throw TickerError.invalidResponse }
        guard let lastTradePrice = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let lowestAsk = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let highestBid = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let percentageChangeLast24Hrs = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let baseCurrencyVolumeLast24Hrs = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let quoteCurrencyVolumeLast24Hrs = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let isFrozen = response[0] as? Int else { throw TickerError.invalidResponse }
        guard let highestTradePriceLast24Hrs = response[0] as? Double else { throw TickerError.invalidResponse }
        guard let lowestTradePriceLast24Hrs = response[0] as? Double else { throw TickerError.invalidResponse }

        self.currencyPairID = currencyPairID
        self.lastTradePrice = lastTradePrice
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.percentageChangeLast24Hrs = percentageChangeLast24Hrs
        self.baseCurrencyVolumeLast24Hrs = baseCurrencyVolumeLast24Hrs
        self.quoteCurrencyVolumeLast24Hrs = quoteCurrencyVolumeLast24Hrs
        self.isFrozen = isFrozen == 0 ? false : true
        self.highestTradePriceLast24Hrs = highestTradePriceLast24Hrs
        self.lowestTradePriceLast24Hrs = lowestTradePriceLast24Hrs
    }
}
