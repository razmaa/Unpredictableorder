import Foundation

private let semaphore = DispatchSemaphore(value: 2)

private let group = DispatchGroup()

func performTask(id: Int) {
    semaphore.wait()
    
    print("Task \(id) started")
    sleep(1)
    print("Task \(id) finished")
    
    semaphore.signal()
    group.leave()
}

func runConcurrentTasks() {
    for id in 1...5 {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            performTask(id: id)
        }
    }
    
    group.wait()
}

runConcurrentTasks()

