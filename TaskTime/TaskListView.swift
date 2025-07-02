//
//  TaskListView.swift
//  
//
//  Created by Bence Családi on 2025. 07. 02..
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var newTaskName = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Task", text: $newTaskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        guard !newTaskName.isEmpty else { return }
                        viewModel.addTask(name: newTaskName)
                        newTaskName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()

                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(task.name)
                                    .font(.headline)
                                Text("Time: \(Int(task.totalTime)) seconds")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                viewModel.toggleTimer(for: task)
                            }) {
                                Text(task.isTracking ? "Stop" : "Start")
                                    .foregroundColor(task.isTracking ? .red : .green)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("TaskTime")
        }
    }
}


