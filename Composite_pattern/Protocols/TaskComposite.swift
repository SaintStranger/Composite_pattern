//
//  Composite_Pattern.swift
//  Composite
//
//  Created by Anton Chechevichkin on 06.09.2022.
//

import Foundation

protocol Tasks: AnyObject {
    var taskName: String { get }
    var taskCount: String { get }
    func read() -> [Tasks]
}
