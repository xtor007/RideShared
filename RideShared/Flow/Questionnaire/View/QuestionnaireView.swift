//
//  QuestionnaireView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct QuestionnaireView: View {
    
    @State var musicalPreferences = ""

    var body: some View {
        
        let blocks: [QuestionnaireBlock] = [
            .music($musicalPreferences),
            .driverGender,
            .driverAge,
            .speed,
            .carColor
        ]
        
        VStack {
            Text(Strings.Questionnaire.title)
                .multilineTextAlignment(.center)
                .font(.title)
                .foregroundColor(Color(Asset.Colors.textColor.color))
            ScrollView(showsIndicators: false) {
                VStack(spacing: Paddings.padding16) {
                    ForEach(0..<blocks.count, id: \.self) { blockIndex in
                        QuestionnaireBlockView(
                            blockName: blocks[blockIndex].title.lowercased(),
                            contentView: blocks[blockIndex].content,
                            priority: .constant(.medium)
                        )
                    }
                }
            }
            BigButton(title: Strings.Button.finish.uppercased()) {
                print("1")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Paddings.padding16)
        .padding(.top, Paddings.padding20)
        .background(
            Color(Asset.Colors.backgroundColor.color).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        
    }

}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView()
    }
}
