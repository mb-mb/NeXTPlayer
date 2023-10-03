//
//  Constants.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 30/09/23.
//

import Foundation

let accessTokenKey = "access-token-key"
//let redirectUri = URL(string:"nextplayerpro://")!
let redirectURL = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
//let redirectURL = "spotify-ios-quick-start"
let spotifyClientId = "8151e44bf07c4ea894700bb542c20020"
let spotifyClientSecretKey = "2b467150281e41bc8f7a8c4dd76e124b"
let tokenAPIURL = "https://accounts.spotify.com/api/token"
/*
Scopes let you specify exactly what types of data your application wants to
access, and the set of scopes you pass in your call determines what access
permissions the user is asked to grant.
For more information, see https://developer.spotify.com/web-api/using-scopes/.
*/
let scopes: SPTScope = [
                            .userReadEmail, .userReadPrivate,
                            .userReadPlaybackState, .userModifyPlaybackState, .userReadCurrentlyPlaying,
                            .streaming, .appRemoteControl,
                            .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
                            .userLibraryModify, .userLibraryRead,
                            .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
                            .userFollowRead, .userFollowModify,
                        ]
let stringScopes = [
                        "user-read-email", "user-read-private",
                        "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
                        "streaming", "app-remote-control",
                        "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
                        "user-library-modify", "user-library-read",
                        "user-top-read", "user-read-playback-position", "user-read-recently-played",
                        "user-follow-read", "user-follow-modify",
                    ]
