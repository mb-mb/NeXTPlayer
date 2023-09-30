//
//  NeXTPlayerEnvironmentKey.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import Foundation
import SwiftUI

private struct NeXTPlayerEnvironmentKey: EnvironmentKey {
    static let defaultValue: String = "Default Value"
}
extension EnvironmentValues {
    var nextPlayerCustomValue: String {
        get { self[NeXTPlayerEnvironmentKey.self] }
        set { self[NeXTPlayerEnvironmentKey.self] = newValue }
    }
}

private struct BackgroundColorView: EnvironmentKey {
    static let defaultValue = Color.gray.opacity(0.4)
}
extension EnvironmentValues {
    var backgroundColorView: Color {
        get { self[BackgroundColorView.self] }
        set { self[BackgroundColorView.self] = newValue }
    }
}


private struct AlbumListColor: EnvironmentKey {
    static let defaultValue = Color.gray.opacity(0.7)
}
extension EnvironmentValues {
    var albumListColor: Color {
        get { self[AlbumListColor.self] }
        set { self[AlbumListColor.self] = newValue }
    }
}

private struct FontNextPlayer: EnvironmentKey {
    static let defaultValue: String = "American Typewriter"
}
extension EnvironmentValues {
    var fontNextPlayer: String {
        get { self[FontNextPlayer.self] }
        set { self[FontNextPlayer.self] = newValue }
    }
}

private struct SizeForSongs: EnvironmentKey {
    static let defaultValue: Int = 12
}
extension EnvironmentValues {
    var sizeForSongs: Int {
        get { self[SizeForSongs.self] }
        set { self[SizeForSongs.self] = newValue }
    }
}

extension View {
    func nextPlayerCustomValue(_ nextPlayerCustomValue: String) -> some View {
        environment(\.nextPlayerCustomValue, nextPlayerCustomValue)
    }
    
    func backgroundColorView(_ color: Color) -> Color {
        environment(\.backgroundColorView, color) as! Color
    }
    
    func albumListColor(_ color: Color) -> Color {
        environment(\.albumListColor, color) as! Color
    }
    
    
    func fontNextPlayer(_ fontName: String) -> some View {
        environment(\.fontNextPlayer, fontName)
    }
    func sizeForSongs(_ sizeForSong: Int) -> some View {
        environment(\.sizeForSongs, sizeForSong)
    }
}


