//
//  CompletionHandler.swift
//  QuerosermbChallenge
//
//  Created by Lazaro on 13/07/20.
//  Copyright © 2020 LimasCompany. All rights reserved.
//

typealias CompletionHandler<T, E: Error> = ((Result<T, E>) -> Void)
