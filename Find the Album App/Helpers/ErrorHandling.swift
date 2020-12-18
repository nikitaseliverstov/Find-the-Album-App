import Foundation

enum ErrorHandling: Error {
    case iTunesUrlIsEmpty
    case dataIsIncorrect
}

extension ErrorHandling: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .iTunesUrlIsEmpty:
            return String("The link for receiving data from the iTunes server is empty")
        case .dataIsIncorrect:
            return String("Album data is invalid")
        }
    }
}
