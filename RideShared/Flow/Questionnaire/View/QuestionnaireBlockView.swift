//
//  QuestionnaireBlockView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct QuestionnaireBlockView: View {

    let blockName: String
    let contentView: AnyView

    @State private var selectedIndex: Int

    @Binding var priority: BlockImportance

    var body: some View {
        VStack {
            HStack {
                Text(blockName)
                    .font(.italic(.headline)())
                    .foregroundColor(Color(Asset.Colors.textColor.color))
                Spacer()
            }
            Picker("", selection: $selectedIndex) {
                ForEach(0..<BlockImportance.allCases.count, id: \.self) { index in
                    Text(BlockImportance(rawValue: index)!.title).tag(index)
                }
            }
            .pickerStyle(.segmented)
            if selectedIndex != 0 {
                contentView
                    .transition(.scale.animation(.default))
            }
        }
        .onChange(of: selectedIndex) { newValue in
            priority = BlockImportance(rawValue: newValue)!
        }
        .onChange(of: priority) { newValue in
            self.selectedIndex = newValue.rawValue
        }
    }

    init(blockName: String, contentView: AnyView, priority: Binding<BlockImportance>) {
        self.blockName = blockName
        self.contentView = contentView
        self._priority = priority
        self.selectedIndex = priority.wrappedValue.rawValue
    }

}

struct QuestionnaireBlockView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireBlockView(blockName: "name", contentView: AnyView(Text("View")), priority: .constant(.medium))
    }
}
