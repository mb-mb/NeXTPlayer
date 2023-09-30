//
//  ContentView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.backgroundColorView) var backgroundColor
    @Environment(\.managedObjectContext) var container
    var cancellable = Set<AnyCancellable>()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            ToolMenu(viewModel: viewModel)
            self.content
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(backgroundColor)
        .navigationBarTitle(Text("Lib"))
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
    
    
    private var content: some View {
        switch viewModel.state {
        case .start:
            return AnyView(AlbumsListView(viewModel: viewModel ))
        case .configuring:
            return AnyView(ConfiguringView(viewModel: viewModel ))
        case .loading:   return AnyView(AlbumsListView(viewModel: viewModel))
        case .config:    return AnyView(ConfigView())
        case .group:     return AnyView(AlbumsViewGroup(viewModel: viewModel))
        case .detail:    return AnyView(ALbumDetailView(viewModel: viewModel))
        case .error:     return AnyView(AlbumsListView(viewModel: viewModel))
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(stateMachine: StateMachine(state: .start)))
    }
}

struct ToolMenu: View {
    @Environment(\.fontNextPlayer) var fontNextPlayer
    @ObservedObject var viewModel: ContentViewModel
    @State var isMainMenu: Bool = true
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeNow = ""
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            
            detailView()
            
            HStack(alignment: .bottom) {
                
                Button(action: {
                    viewModel.state = ( (viewModel.state == .group || viewModel.state == .config) ? .start : .config )

                }) {
                    Image(systemName: (isMainMenu ? "gear" : "menubar.rectangle") )
                        .frame(width: 23, height: 23, alignment: .center)
                }
                .buttonStyle(ButtonMenu())
                .accessibility(identifier: "buttonMenuChange")
                
                Text(timeNow)
                    .font(.custom(fontNextPlayer, size: CGFloat(12), relativeTo: .headline))
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 18, leading: 5, bottom: 3, trailing: 10))
                    .frame(width: 180, height: 30, alignment: .leading)
                    .onReceive(timer) { _ in
                        self.timeNow = viewModel.menuTime()
                    }
                    .accessibilityIdentifier("menuTime")
                
                Spacer()
            }
            .statusBar(hidden: true)
            .frame(height: 55, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            .animation(.easeInOut)
            .statusBar(hidden: true)
            
            
        }
    }
    
    private func detailView() -> AnyView {
        var ret:AnyView = AnyView(HStack { Text("")
            .font(.custom(fontNextPlayer, size: CGFloat(16), relativeTo: .headline))
            .background(Color.blue)}
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .frame(width: 0, height: 0, alignment: .trailing))
        
        if self.viewModel.state == .detail {
            ret = AnyView(HStack(alignment: .top) {
                Spacer()
                Text("< go back")
                .font(.custom(fontNextPlayer, size: CGFloat(16), relativeTo: .headline))
                .background(Color.clear)
                .frame(width: 80, height: 10, alignment: .center)
                
            }
            .frame(width: 80, height: 35, alignment: .trailing)
            .background(Color.blue)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: -20, trailing: 0))
            )

            
            
            
        }
        
        return ret
    }
  

      
}

struct ButtonMenu: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Color.black)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0))
            .background(Color.clear)
    }
}


