import UIKit

class GenericClassForViewControllers<CustomView: UIView>: UIViewController {
    let customView = CustomView()

    override func loadView() {
        view = customView
    }
}
