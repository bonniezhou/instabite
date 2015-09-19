//
//  OauthController.swift
//  
//
//  Created by Lily Nguyen on 9/19/15.
//
//

import Foundation
import OAuthSwift

class OAuthController   {
    let oauthswift = OAuth2Swift(
        consumerKey:    "********",
        consumerSecret: "********",
        authorizeUrl:   "https://api.instagram.com/oauth/authorize",
        responseType:   "token"
    )
}