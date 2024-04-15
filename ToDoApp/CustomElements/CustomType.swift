//
//  CustomType.swift
//  TestTask
//
//  Created by Mac on 27.03.2024.
//

import Foundation
import RealmSwift

typealias NetworkCompletionHandler = (Result<Articles, Error>) -> Void
typealias ActionWithRealm = (Realm) throws -> Void
typealias UndefinedAction = () -> Void
