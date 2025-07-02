//
//  TaskListViewModel.swift
//  
//
//  Created by Bence Családi on 2025. 07. 02..
//

import Foundation
import RealmSwift

@MainActor
class TaskListViewModel: ObservableObject {
    private let realm = try! Realm()
    @Published var tasks: [Task] = []

    init() {
        loadTasks()
    }

    func loadTasks() {
        tasks = Array(realm.objects(Task.self))
    }

    func addTask(name: String) {
        let task = Task()
        task.name = name
        try! realm.write {
            realm.add(task)
        }
        loadTasks()
    }

    func toggleTimer(for task: Task) {
        try! realm.write {
            if task.isTracking {
                if let start = task.startTime {
                    let elapsed = Date().timeIntervalSince(start)
                    task.totalTime += elapsed
                }
                task.isTracking = false
                task.startTime = nil
            } else {
                task.isTracking = true
                task.startTime = Date()
            }
        }
        loadTasks()
    }
}
