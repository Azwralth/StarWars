//
//  CommandsInvoker.swift
//  StarWars
//
//  Created by Владислав Соколов on 13.01.2025.
//

import Foundation

final class CommandInvoker {
    private var commandQueue: [Command] = []

    func addCommand(_ command: Command) {
        commandQueue.append(command)
    }

    func executeCommands() {
        commandQueue.forEach { $0.execute() }
        commandQueue.removeAll()
    }
}
