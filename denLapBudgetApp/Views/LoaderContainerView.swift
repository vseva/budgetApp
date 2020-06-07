//
//  LoaderContainerView.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 07.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import SwiftUI


private let kPreviewBackground = Color(red: 237/255.0, green: 85/255.0, blue: 101/255.0)

struct LoaderContainerView: View {
    var body: some View {
        ZStack {
            kPreviewBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                LoaderView().frame(width: 50, height: 50)
            }.foregroundColor(Color.white)
        }
    }
}

struct LoaderContainerView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderContainerView()
    }
}
