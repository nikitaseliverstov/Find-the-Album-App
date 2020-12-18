import Network

final class CheckInternetConnection {
    func checksTheInternetConnection(noConnectionCompletionHandler: @escaping () -> Void) {
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                DispatchQueue.main.async {
                    noConnectionCompletionHandler()
                    print("No connection.")
                }
            }
            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
