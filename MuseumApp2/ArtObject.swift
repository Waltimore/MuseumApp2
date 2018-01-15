/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ArtObject : Codable {
	//let links : Links?
	//let id : String?
	//let priref : String?
	//let objectNumber : String?
	//let language : String?
	//let title : String?
	//let copyrightHolder : String?
	//let webImage : WebImage?
	//let colors : [String]?
	//let colorsWithNormalization : [String]?
//    let normalizedColors : [String]?
//    let normalized32Colors : [String]?
//    let titles : [String]?
//    let description : String?
//    let labelText : String?
//    let objectTypes : [String]?
//    let objectCollection : [String]?
//    let makers : [String]?
//    let principalMakers : [PrincipalMakers]?
//    let plaqueDescriptionDutch : String?
//    let plaqueDescriptionEnglish : String?
//    let principalMaker : String?
//    let artistRole : String?
//    let associations : [String]?
//    let acquisition : Acquisition?
//    let exhibitions : [String]?
//    let materials : [String]?
//    let techniques : [String]?
//    let productionPlaces : [String]?
//    let dating : Dating?
//    let classification : Classification?
//    let hasImage : Bool?
//    let historicalPersons : [String]?
//    let inscriptions : [String]?
//    let documentation : [String]?
//    let catRefRPK : [String]?
//    let principalOrFirstMaker : String?
//    let dimensions : [Dimensions]?
//    let physicalProperties : [String]?
//    let physicalMedium : String?
//    let longTitle : String?
//    let subTitle : String?
//    let scLabelLine : String?
	let label : Label?
//    let showImage : Bool?
//    let location : String?

	enum CodingKeys: String, CodingKey {

//        case links
//        case id = "id"
//        case priref = "priref"
//        case objectNumber = "objectNumber"
//        case language = "language"
//        case title = "title"
//        case copyrightHolder = "copyrightHolder"
//        case webImage
//        case colors = "colors"
//        case colorsWithNormalization = "colorsWithNormalization"
//        case normalizedColors = "normalizedColors"
//        case normalized32Colors = "normalized32Colors"
//        case titles = "titles"
//        case description = "description"
//        case labelText = "labelText"
//        case objectTypes = "objectTypes"
//        case objectCollection = "objectCollection"
//        case makers = "makers"
//        case principalMakers = "principalMakers"
//        case plaqueDescriptionDutch = "plaqueDescriptionDutch"
//        case plaqueDescriptionEnglish = "plaqueDescriptionEnglish"
//        case principalMaker = "principalMaker"
//        case artistRole = "artistRole"
//        case associations = "associations"
//        case acquisition
//        case exhibitions = "exhibitions"
//        case materials = "materials"
//        case techniques = "techniques"
//        case productionPlaces = "productionPlaces"
//        case dating
//        case classification
//        case hasImage = "hasImage"
//        case historicalPersons = "historicalPersons"
//        case inscriptions = "inscriptions"
//        case documentation = "documentation"
//        case catRefRPK = "catRefRPK"
//        case principalOrFirstMaker = "principalOrFirstMaker"
//        case dimensions = "dimensions"
//        case physicalProperties = "physicalProperties"
//        case physicalMedium = "physicalMedium"
//        case longTitle = "longTitle"
//        case subTitle = "subTitle"
//        case scLabelLine = "scLabelLine"
		case label
//        case showImage = "showImage"
//        case location = "location"
	}

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        links = try Links(from: decoder)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        priref = try values.decodeIfPresent(Int.self, forKey: .priref)
//        objectNumber = try values.decodeIfPresent(String.self, forKey: .objectNumber)
//        language = try values.decodeIfPresent(String.self, forKey: .language)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        copyrightHolder = try values.decodeIfPresent(String.self, forKey: .copyrightHolder)
//        webImage = try WebImage(from: decoder)
//        colors = try values.decodeIfPresent([String].self, forKey: .colors)
//        colorsWithNormalization = try values.decodeIfPresent([String].self, forKey: .colorsWithNormalization)
//        normalizedColors = try values.decodeIfPresent([String].self, forKey: .normalizedColors)
//        normalized32Colors = try values.decodeIfPresent([String].self, forKey: .normalized32Colors)
//        titles = try values.decodeIfPresent([String].self, forKey: .titles)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        labelText = try values.decodeIfPresent(String.self, forKey: .labelText)
//        objectTypes = try values.decodeIfPresent([String].self, forKey: .objectTypes)
//        objectCollection = try values.decodeIfPresent([String].self, forKey: .objectCollection)
//        makers = try values.decodeIfPresent([String].self, forKey: .makers)
//        principalMakers = try values.decodeIfPresent([PrincipalMakers].self, forKey: .principalMakers)
//        plaqueDescriptionDutch = try values.decodeIfPresent(String.self, forKey: .plaqueDescriptionDutch)
//        plaqueDescriptionEnglish = try values.decodeIfPresent(String.self, forKey: .plaqueDescriptionEnglish)
//        principalMaker = try values.decodeIfPresent(String.self, forKey: .principalMaker)
//        artistRole = try values.decodeIfPresent(String.self, forKey: .artistRole)
//        associations = try values.decodeIfPresent([String].self, forKey: .associations)
//        acquisition = try Acquisition(from: decoder)
//        exhibitions = try values.decodeIfPresent([String].self, forKey: .exhibitions)
//        materials = try values.decodeIfPresent([String].self, forKey: .materials)
//        techniques = try values.decodeIfPresent([String].self, forKey: .techniques)
//        productionPlaces = try values.decodeIfPresent([String].self, forKey: .productionPlaces)
//        dating = try Dating(from: decoder)
//        classification = try Classification(from: decoder)
//        hasImage = try values.decodeIfPresent(Bool.self, forKey: .hasImage)
//        historicalPersons = try values.decodeIfPresent([String].self, forKey: .historicalPersons)
//        inscriptions = try values.decodeIfPresent([String].self, forKey: .inscriptions)
//        documentation = try values.decodeIfPresent([String].self, forKey: .documentation)
//        catRefRPK = try values.decodeIfPresent([String].self, forKey: .catRefRPK)
//        principalOrFirstMaker = try values.decodeIfPresent(String.self, forKey: .principalOrFirstMaker)
//        dimensions = try values.decodeIfPresent([Dimensions].self, forKey: .dimensions)
//        physicalProperties = try values.decodeIfPresent([String].self, forKey: .physicalProperties)
//        physicalMedium = try values.decodeIfPresent(String.self, forKey: .physicalMedium)
//        longTitle = try values.decodeIfPresent(String.self, forKey: .longTitle)
//        subTitle = try values.decodeIfPresent(String.self, forKey: .subTitle)
//        scLabelLine = try values.decodeIfPresent(String.self, forKey: .scLabelLine)
//        label = try Label(from: decoder)
//        showImage = try values.decodeIfPresent(Bool.self, forKey: .showImage)
//        location = try values.decodeIfPresent(String.self, forKey: .location)
//    }

}
