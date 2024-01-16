//
//  ContentView.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 04/01/24.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var name: String
    var isCompleted = false
}

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(name: String) {
        tasks.append(Task(name: name))
    }

    func toggleTaskCompletion(index: Int) {
        DispatchQueue.main.async {
            self.tasks[index].isCompleted.toggle()
        }
    }

    func removeTask(index: Int) {
        DispatchQueue.main.async {
            self.tasks.remove(at: index)
        }
    }
}

struct ContentView: View {
    @ObservedObject var taskManager = TaskManager()
    @State private var newTaskName = ""
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new task", text: $newTaskName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Add Task") {
                    taskManager.addTask(name: newTaskName)
                    newTaskName = ""
                }
                .padding()

                List {
                    ForEach(taskManager.tasks.indices, id:\.self) { index in
                        TaskRow(task: taskManager.tasks[index], toggleCompletion: {
                            taskManager.toggleTaskCompletion(index: index)
                        }, removeTask: {
                            taskManager.removeTask(index: index)
                        })
                    }
                }
            }
            .navigationTitle("To-Do List")
        }
    }
}

struct TaskRow: View {
    var task: Task
    var toggleCompletion: () -> Void
    var removeTask: () -> Void

    var body: some View {
        HStack {
            Button(action: {
                toggleCompletion()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
            }

            Text(task.name)
                .strikethrough(task.isCompleted, color: .gray)

            Spacer()

            Button(action: {
                removeTask()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
