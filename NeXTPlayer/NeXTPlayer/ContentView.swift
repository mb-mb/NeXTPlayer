//
//  ContentView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @StateObject var localViewModel = LocalListViewModel()
    let isBannerEnabled = UserDefaults.standard.bool(forKey: "isBannerEnabled")
    var body: some View {
        VStack{
            LocalSearchAllListView()
                .environmentObject(localViewModel)
            if  isBannerEnabled {
                HStack(alignment: .bottom) {
                    Spacer()
                    SwiftUIBannerAd(adPosition: .bottom,
                                    adUnitId: SwiftUIMobileAds.bannerIdProd)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
