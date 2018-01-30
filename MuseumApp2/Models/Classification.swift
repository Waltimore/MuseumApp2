/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Classification : Codable {
	let iconClassIdentifier : [String]?
	let iconClassDescription : [String]?
	let motifs : [String]?
	let events : [String]?
	let periods : [String]?
	let places : [String]?
	let people : [String]?
	let objectNumbers : [String]?

	enum CodingKeys: String, CodingKey {

		case iconClassIdentifier = "iconClassIdentifier"
		case iconClassDescription = "iconClassDescription"
		case motifs = "motifs"
		case events = "events"
		case periods = "periods"
		case places = "places"
		case people = "people"
		case objectNumbers = "objectNumbers"
	}

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        iconClassIdentifier = try values.decodeIfPresent([String].self, forKey: .iconClassIdentifier)
//        iconClassDescription = try values.decodeIfPresent([String].self, forKey: .iconClassDescription)
//        motifs = try values.decodeIfPresent([String].self, forKey: .motifs)
//        events = try values.decodeIfPresent([String].self, forKey: .events)
//        periods = try values.decodeIfPresent([String].self, forKey: .periods)
//        places = try values.decodeIfPresent([String].self, forKey: .places)
//        people = try values.decodeIfPresent([String].self, forKey: .people)
//        objectNumbers = try values.decodeIfPresent([String].self, forKey: .objectNumbers)
//    }

}
