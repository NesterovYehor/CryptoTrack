
import Foundation

// JSON data:
/*
URL: https://api.coingecko.com/api/v3/global

JSON response:
{
"data": {
    "active_cryptocurrencies": 13016,
    "upcoming_icos": 0,
    "ongoing_icos": 49,
    "ended_icos": 3376,
    "markets": 766,
    "total_market_cap": {
    "btc": 46815829.99145831,
    "eth": 694780268.9632199,
    "ltc": 17709198227.927082,
    "bch": 6333563637.946127,
    "bnb": 4780226520.583864,
    "eos": 909566161790.446,
    "xrp": 2450948739898.2144,
    "xlm": 10309773610994.771,
    "link": 134751653371.27531,
    "dot": 107304780327.60716,
    "yfi": 93971555.8687857,
    "usd": 1832232823197.2815,
    "aed": 6729791159603.605,
    "ars": 198722203899302.8,
    "aud": 2488459834455.15,
    "bdt": 157233827428227.5,
    "bhd": 690755438811.0219,
    "bmd": 1832232823197.2815,
    "brl": 9266808828339.129,
    "cad": 2336197622381.8105,
    "chf": 1693937721935.1736,
    "clp": 1475497092520770.5,
    "cny": 11577512763218.988,
    "czk": 42936395567946.4,
    "dkk": 12498076003879.5,
    "eur": 1679605996792.1238,
    "gbp": 1390144358684.9487,
    "hkd": 14321611217865.078,
    "huf": 659890888757525.9,
    "idr": 26365463879244230,
    "ils": 5994032418189.208,
    "inr": 140582920609025.73,
    "jpy": 211211554810477.97,
    "krw": 2248126674044432.8,
    "kwd": 556681801973.5599,
    "lkr": 369415391946565.94,
    "mmk": 3251874131369697.5,
    "mxn": 38650108578247.984,
    "myr": 7654519065471.272,
    "ngn": 761292738038470.1,
    "nok": 16543290624331.426,
    "nzd": 2672639542308.587,
    "php": 95592168800493.12,
    "pkr": 325496161040997,
    "pln": 8348204244566.594,
    "rub": 261093177305612.4,
    "sar": 6874544881567.497,
    "sek": 18203170802549.016,
    "sgd": 2492446773078.4263,
    "thb": 60243815226726.484,
    "try": 26261123716661.62,
    "twd": 51721186081857.44,
    "uah": 54957389292623.25,
    "vef": 183461472586.7439,
    "vnd": 41870039280414210,
    "zar": 28026252844942.12,
    "xdr": 1319447655201.8813,
    "xag": 71863579278.84865,
    "xau": 927164775.5225189,
    "bits": 46815829991458.31,
    "sats": 4681582999145831
    },
    "total_volume": {
    "btc": 2122973.5919537186,
    "eth": 31506440.524252925,
    "ltc": 803065120.9093659,
    "bch": 287210295.0811982,
    "bnb": 216770580.9895486,
    "eos": 41246410497.64864,
    "xrp": 111144017973.9526,
    "xlm": 467520860340.54395,
    "link": 6110629708.61595,
    "dot": 4865986888.782462,
    "yfi": 4261360.559892556,
    "usd": 83086893870.47795,
    "aed": 305178161186.2651,
    "ars": 9011524330339.455,
    "aud": 112845046518.4467,
    "bdt": 7130136610903.592,
    "bhd": 31323925162.957943,
    "bmd": 83086893870.47795,
    "brl": 420225176566.06714,
    "cad": 105940359464.0223,
    "chf": 76815578208.02812,
    "clp": 66909875633895.875,
    "cny": 525009464988.7763,
    "czk": 1947051540922.376,
    "dkk": 566754563815.4376,
    "eur": 76165672524.17322,
    "gbp": 63039355769.83355,
    "hkd": 649447044200.713,
    "huf": 29924299764816.74,
    "idr": 1195603785417403.2,
    "ils": 271813455736.06027,
    "inr": 6375062195568.071,
    "jpy": 9577883234366.27,
    "krw": 101946575789297.6,
    "kwd": 25244041703.985683,
    "lkr": 16752007210101.42,
    "mmk": 147463857983825.03,
    "mxn": 1752679806226.552,
    "myr": 347112116522.69525,
    "ngn": 34522604403183.574,
    "nok": 750194306624.0433,
    "nzd": 121197107264.0949,
    "php": 4334851053544.411,
    "pkr": 14760386696090.404,
    "pln": 378568897628.9524,
    "rub": 11839882376543.098,
    "sar": 311742358149.60895,
    "sek": 825465465648.8074,
    "sgd": 113025843599.50883,
    "thb": 2731897070461.309,
    "try": 1190872236072.1611,
    "twd": 2345418466709.6875,
    "uah": 2492171690051.134,
    "vef": 8319490683.250962,
    "vnd": 1898695114507257.8,
    "zar": 1270916155541.5266,
    "xdr": 59833447969.84115,
    "xag": 3258822519.222749,
    "xau": 42044460.90527789,
    "bits": 2122973591953.7185,
    "sats": 212297359195371.84
    },
    "market_cap_percentage": {
    "btc": 40.53496254569975,
    "eth": 17.251848612515687,
    "usdt": 4.363933886047952,
    "bnb": 3.517346594116339,
    "usdc": 2.864892317561995,
    "xrp": 1.9574324726406782,
    "luna": 1.6708645465443854,
    "sol": 1.4966984100954142,
    "ada": 1.476967739883975,
    "avax": 1.1022121787603252
    },
    "market_cap_change_percentage_24h_usd": -0.004425096574067805,
    "updated_at": 1646664122
}
}

*/
 

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
            return key == "usd"
        }){
            return "$" + item.value.formatedWithAbbreviations() 
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { (key, value) -> Bool in
            return key == "usd"
        }){
            return "$" + item.value.formatedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return "\(item.value.formatedWithAbbreviations())"
        }
        return ""
    }
}

