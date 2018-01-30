/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ArtObjects : Codable {
//    let links : Links?
//    let id : String?
	let objectNumber : String?
	let title : String?
//    let hasImage : Bool?
//    let principalOrFirstMaker : String?
//    let longTitle : String?
//    let showImage : Bool?
//    let permitDownload : Bool?
//    let webImage : String?
//    let headerImage : String?
//    let productionPlaces : [String]?

	enum CodingKeys: String, CodingKey {

//        case links
//        case id = "id"
		case objectNumber = "objectNumber"
		case title = "title"
//        case hasImage = "hasImage"
//        case principalOrFirstMaker = "principalOrFirstMaker"
//        case longTitle = "longTitle"
//        case showImage = "showImage"
//        case permitDownload = "permitDownload"
//        case webImage = "webImage"
//        case headerImage = "headerImage"
//        case productionPlaces = "productionPlaces"
	}
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        links = try Links(from: decoder)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        objectNumber = try values.decodeIfPresent(String.self, forKey: .objectNumber)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        hasImage = try values.decodeIfPresent(Bool.self, forKey: .hasImage)
//        principalOrFirstMaker = try values.decodeIfPresent(String.self, forKey: .principalOrFirstMaker)
//        longTitle = try values.decodeIfPresent(String.self, forKey: .longTitle)
//        showImage = try values.decodeIfPresent(Bool.self, forKey: .showImage)
//        permitDownload = try values.decodeIfPresent(Bool.self, forKey: .permitDownload)
//        webImage = try values.decodeIfPresent(String.self, forKey: .webImage)
//        headerImage = try values.decodeIfPresent(String.self, forKey: .headerImage)
//        productionPlaces = try values.decodeIfPresent([String].self, forKey: .productionPlaces)
//    }

}
