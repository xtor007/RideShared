//
//  MusicBlockView.swift
//  RideShared
//
//  Created by Anatoliy Khramchenko on 18.12.2022.
//

import SwiftUI

struct MusicBlockView: View {

    @Binding var musicalPreferences: String

    var body: some View {
        TextField(Strings.MusicBlock.placeholder, text: $musicalPreferences)
            .textFieldStyle(.roundedBorder)
            .frame(height: 50)
    }

}

struct MusicBlockView_Previews: PreviewProvider {
    static var previews: some View {
        MusicBlockView(musicalPreferences: .constant(""))
            .background(Color.blue)
    }
}
