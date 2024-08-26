
//
//  selectionLists.swift
//	simple selection list
//
//  Created by Parth on 26/08/24.
//

import SwiftUI

struct listsOption 	: Identifiable {
	let id 			= UUID()
	let title		: String
	let colorCode	: String
	var isSelected	: Bool = false
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

	/// Flips on and off
	/// - Parameter id: passed in the view for each
	func setResetSelections(optionId id : UUID) {
		for index in options.indices {
			options[index].isSelected = (options[index].id == id)
		}
	}
}

struct ColorListView: View {
	@State var sampleVieModelObj: sampleViewModel = sampleViewModel()

	private func changeColorOnSelection(isSelected: Bool) -> Color {
		return Color(.green).opacity(isSelected ? 1.0 : 0.3)
	}

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
						Image(systemName: "circle.fill")
							.frame(width: 40, height: 40, alignment: .leading)
							.foregroundStyle(changeColorOnSelection(isSelected: options.isSelected))

						Text(options.title)
							.foregroundStyle(.primary)
					}
					.padding()
					.frame( maxWidth: .infinity, alignment: .leading)
					.cornerRadius(12)
					.overlay {
						RoundedRectangle(cornerRadius: 12)
							.stroke(

								options.isSelected ?
								Color(hex: options.colorCode) ?? .accentColor : Color.clear,
								lineWidth: 2)
					}
					.scaleEffect(options.isSelected ? 1.05 : 1.0)
					.animation(.bouncy, value: options.isSelected)
					.onTapGesture {
						sampleVieModelObj.setResetSelections(optionId: options.id)
					}
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
