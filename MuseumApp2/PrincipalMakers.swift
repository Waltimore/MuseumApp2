/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct PrincipalMakers : Codable {
	let name : String?
	let unFixedName : String?
	let placeOfBirth : String?
	let dateOfBirth : String?
	let dateOfBirthPrecision : String?
	let dateOfDeath : String?
	let dateOfDeathPrecision : String?
	let placeOfDeath : String?
	let occupation : [String]?
	let roles : [String]?
	let nationality : String?
	let biography : String?
	let productionPlaces : [String]?
	let qualification : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case unFixedName = "unFixedName"
		case placeOfBirth = "placeOfBirth"
		case dateOfBirth = "dateOfBirth"
		case dateOfBirthPrecision = "dateOfBirthPrecision"
		case dateOfDeath = "dateOfDeath"
		case dateOfDeathPrecision = "dateOfDeathPrecision"
		case placeOfDeath = "placeOfDeath"
		case occupation = "occupation"
		case roles = "roles"
		case nationality = "nationality"
		case biography = "biography"
		case productionPlaces = "productionPlaces"
		case qualification = "qualification"
	}

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        unFixedName = try values.decodeIfPresent(String.self, forKey: .unFixedName)
//        placeOfBirth = try values.decodeIfPresent(String.self, forKey: .placeOfBirth)
//        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
//        dateOfBirthPrecision = try values.decodeIfPresent(String.self, forKey: .dateOfBirthPrecision)
//        dateOfDeath = try values.decodeIfPresent(String.self, forKey: .dateOfDeath)
//        dateOfDeathPrecision = try values.decodeIfPresent(String.self, forKey: .dateOfDeathPrecision)
//        placeOfDeath = try values.decodeIfPresent(String.self, forKey: .placeOfDeath)
//        occupation = try values.decodeIfPresent([String].self, forKey: .occupation)
//        roles = try values.decodeIfPresent([String].self, forKey: .roles)
//        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
//        biography = try values.decodeIfPresent(String.self, forKey: .biography)
//        productionPlaces = try values.decodeIfPresent([String].self, forKey: .productionPlaces)
//        qualification = try values.decodeIfPresent(String.self, forKey: .qualification)
//    }

}
