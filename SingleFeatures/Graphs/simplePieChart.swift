//
//  simplePieChart.swift
//  Show market shares of phones in Q2 2024 - India
//  Source some reddit post on r/TechIndia
//
//  Created by Parth on 25/08/24.
//

import Charts
import SwiftUI

struct chartDataSource : Identifiable {
	let id 			= UUID()
	let brandName	: String
	let marketShare	: Double
}

struct teststets: View {

	// initialize with data
	@State private var phonesCompanies: [chartDataSource] =
	[
		.init(brandName: "Vivo"		, marketShare: 16.50)	,
		.init(brandName: "Xiaomi"	, marketShare: 13.50)	,
		.init(brandName: "Samsung"	, marketShare: 12.90)	,
		.init(brandName: "RealMe"	, marketShare: 12.60)	,
		.init(brandName: "Oppo"		, marketShare: 11.50)	,
		.init(brandName: "Apple"	, marketShare: 06.70)	,
		.init(brandName: "Moto"		, marketShare: 06.20)	,
		.init(brandName: "Poco"		, marketShare: 05.70)	,
		.init(brandName: "Others"	, marketShare: 14.30)
	]

	var body: some View {

		ZStack {
			// chart
			Chart(phonesCompanies) { companies in
				SectorMark (
					angle: .value(
						companies.brandName,
						companies.marketShare),
					innerRadius: .ratio(0.5),
					angularInset: 1
				)
				// foregroundstyle sorting by does the trick of adding different color and name
				// adds a list at bottom and sets color depending on name
				// can be changed depending on brand name / market share types
				.foregroundStyle(by: .value(Text(verbatim: companies.brandName), companies.brandName)
				)
				.annotation(position: .overlay) {
					Text("\(companies.brandName) \n" + String(format: "%.2f", companies.marketShare) + "%")
						.font(.title2)
						.foregroundStyle(.black)
						.fontWeight(.bold)
				}
			}
			// center text and image
			VStack(spacing: -25) {
				Text("Mobile Market Shares \n India")
					.font(.headline)
					.fontWeight(.bold)
					.multilineTextAlignment(.center)
					.frame(width: 150, height: 150)
					.foregroundStyle(.foreground, .background)
				Image(systemName: "iphone.gen1")
					.font(.system(size: 40))
			}
		}
		.padding()

	}

}


#Preview {
	teststets()
}

