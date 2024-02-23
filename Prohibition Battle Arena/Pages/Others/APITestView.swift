//
//  GroupView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/27.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var appModel: AppModel
    var body: some View {
        VStack{
        }
    }
}

#Preview {
    TestView()
        .environmentObject(AppModel())
}
