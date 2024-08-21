//
//  FaqDisclosureGroups.swift
//  LittlestLemon
//
//  Created by Parth on 21/08/24.
//

import SwiftUI

struct Test: View {

	@State var isExpanded : Bool = false

	var body: some View {
		VStack(spacing: 16) {
			Spacer()
				.frame(height: 50)
			VStack(alignment: .leading, spacing: 12) {

				Text("Frequently Asked Questions")
					.font(.title2)
					.fontWeight(.semibold)
					.accessibilityLabel("Faq Header")

				Text("Commonly asked questions and answers about Disclosure groups")
					.font(.subheadline)
					.foregroundStyle(.gray)
			}
			.padding(.vertical)

			Spacer()
				.frame(height: 50)

			DisclosureGroup("Show me what it does ?") {
				Text("Hooray you selected first entry of the Disclosure ")
					.frame(maxWidth: .infinity,alignment: .leading)
					.padding(.vertical) // adds space from top
			}
			.foregroundStyle(.primary)
			.padding(.horizontal)

			DisclosureGroup(isExpanded ? "Click me to close" : "Click me to open",
							isExpanded: $isExpanded) {
				Text("State managed")
			}
							.foregroundStyle(.primary)
							.padding(.horizontal)

			DisclosureGroup(
				content: {
					Image(systemName: "fan")
						.font(.headline)
				},
				label: {
					HStack {
						Image(systemName: "chevron.right")
						Text("Ok Cook ! Show me an image")

					}
				}
			)
			.foregroundStyle(.primary)
			.padding(.horizontal)

			Spacer()

		}
	}
}

#Preview {
	Test()
}

