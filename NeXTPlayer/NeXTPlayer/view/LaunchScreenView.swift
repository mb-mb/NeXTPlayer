//
//  LaunchScreenView.swift
//  BookMap
//
//  Created by marcelo bianchi on 11/08/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    private let time = Timer.publish(every: 0.65,
                                     on: .main,
                                     in: .common).autoconnect()
    
    
    var body: some View {
        if isActive {
            ZStack {
                ContentView()                    
            }
        } else {
            ZStack {
                background
                VStack {
                    VStack {
                        logo
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    info
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

private extension LaunchScreenView {
    
    var background: some View {
        Color("launchBack")
//            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo: some View {
        VStack {
            Image("Logo")
                .foregroundColor(Color(red: 0.1, green: 0.22, blue: 0.338))
                .font(.system(size: 80))
        }
            
    }
    
    var info: some View {
        
        Text("NeXTPlayer")
            .font(Fonts.avenirNext(size: 46))
            .foregroundColor(.white)
        
    }
}
