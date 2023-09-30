//
//  ConfigView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 14/10/21.
//

import SwiftUI

struct ConfigView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 5){
                Spacer()
                VStack(alignment: .leading) {                    
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("login spotify")
                                Text("_____________")
                            }
                            HStack {
                                Text("password")
                                Text("________________")
                            }
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("init on")
                            }
                            HStack {
                                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                                    /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                                }
                                
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 15))
                    .ignoresSafeArea(.all)
                    Spacer()
                }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
            }
            .ignoresSafeArea(.all)
        }
        .ignoresSafeArea(.all)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
