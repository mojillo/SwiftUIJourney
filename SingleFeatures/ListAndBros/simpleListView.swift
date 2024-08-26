//
//  simpleLists.swift
//	simple selection list
//
//  Created by Parth on 26/08/24.
//

import SwiftUI

struct listsOption 	: Identifiable {
	let id 			= UUID()
	let title		: String
	let colorCode	: String
	let isSelected	: Bool = false
}

@Observable
class sampleViewModel {
	var options : [listsOption] = [
		listsOption(title: "✽ Persian Rose"	,colorCode: "#FE28A2")	,
		listsOption(title: "✽ Fuchsia"		,colorCode: "#ED0DD9")	,
		listsOption(title: "✽ Viridian"		,colorCode: "#40826D")	,
		listsOption(title: "✽ Gun Powder"	,colorCode: "#414257")	,
		listsOption(title: "✽ Parchment"		,colorCode: "#FEFCAF")	,
		listsOption(title: "✽ Blue Zircon"	,colorCode: "#57FEFF")]
}

struct ColorListView: View {
	@State var sampleVieModelObj: sampleViewModel = sampleViewModel()
	var body: some View {

		ZStack(alignment: .topLeading) {

			Color(.darkGray)
				.ignoresSafeArea(.all)

			VStack(alignment: .leading, spacing: 15 ) {

				Text("Pick a color ")
					.font(.system(size: 22))
					.bold()

				ForEach(sampleVieModelObj.options) { options in
					HStack {
						Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
							.frame(width: 40, height: 40, alignment: .leading)
							.foregroundStyle(Color(hex: options.colorCode) ?? .black)

						Text(options.title)
							.foregroundStyle(.primary)
					}
					.padding()
					.frame( maxWidth: .infinity, alignment: .leading)
					.border(Color(hex: options.colorCode) ?? .accentColor, width: 0.5)
					.cornerRadius(12)
				}
			}
			.padding()
		}
	}
}

// this converts hex string to color instance
// sampled source from https://github.com/Nyx0uf/SwiftyImages
extension Color {

	init?(hex: String) {

		// removes blank spaces and #
		var hex 		= hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hex 			= hex.replacingOccurrences(of: "#", with: "")

		guard hex.count == 6 else { return nil }

		let scanner 			= Scanner(string: hex)
		var hexNumber: UInt64 	= 0
		if scanner.scanHexInt64(&hexNumber) {
			let red 	= CGFloat((hexNumber & 0xFF0000) >> 16) / 255
			let green 	= CGFloat((hexNumber & 0x00FF00) >> 8) / 255
			let blue 	= CGFloat(hexNumber & 0x0000FF) / 255

			self.init(.sRGB,
					  red: red,
					  green: green,
					  blue: blue,
					  opacity: 1.0)
		}
		else {
			return nil
		}
	}
}
