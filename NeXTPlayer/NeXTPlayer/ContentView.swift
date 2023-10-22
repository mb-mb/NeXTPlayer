//
//  ContentView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {
        Group {
            VStack{
                LocalMusicSearchView()
                if  !viewModel.isBannerEnable {
                    HStack(alignment: .bottom) {
                        Spacer()
                        SwiftUIBannerAd(adPosition: .bottom,
                                        adUnitId: SwiftUIMobileAds.testBannerId)
                        //                    .padding(.bottom, 0)
                    }
                    //        .background(.green)
                    .frame(height: 50)
                }
            }
            .onAppear {
                viewModel.fetchRemoteConfig()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
