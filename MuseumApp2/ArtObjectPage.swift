/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ArtObjectPage : Codable {
	let id : String?
	let similarPages : [String]?
	let lang : String?
	let objectNumber : String?
	let tags : [String]?
	let plaqueDescription : String?
	let audioFile1 : String?
	let audioFileLabel1 : String?
	let audioFileLabel2 : String?
	let createdOn : String?
	let updatedOn : String?
	let adlibOverrides : AdlibOverrides?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case similarPages = "similarPages"
		case lang = "lang"
		case objectNumber = "objectNumber"
		case tags = "tags"
		case plaqueDescription = "plaqueDescription"
		case audioFile1 = "audioFile1"
		case audioFileLabel1 = "audioFileLabel1"
		case audioFileLabel2 = "audioFileLabel2"
		case createdOn = "createdOn"
		case updatedOn = "updatedOn"
		case adlibOverrides
	}

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        similarPages = try values.decodeIfPresent([String].self, forKey: .similarPages)
//        lang = try values.decodeIfPresent(String.self, forKey: .lang)
//        objectNumber = try values.decodeIfPresent(String.self, forKey: .objectNumber)
//        tags = try values.decodeIfPresent([String].self, forKey: .tags)
//        plaqueDescription = try values.decodeIfPresent(String.self, forKey: .plaqueDescription)
//        audioFile1 = try values.decodeIfPresent(String.self, forKey: .audioFile1)
//        audioFileLabel1 = try values.decodeIfPresent(String.self, forKey: .audioFileLabel1)
//        audioFileLabel2 = try values.decodeIfPresent(String.self, forKey: .audioFileLabel2)
//        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
//        updatedOn = try values.decodeIfPresent(String.self, forKey: .updatedOn)
//        adlibOverrides = try AdlibOverrides(from: decoder)
//    }

}
