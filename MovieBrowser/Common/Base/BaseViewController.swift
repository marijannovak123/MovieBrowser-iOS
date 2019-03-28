import UIKit
import RxSwift
import MBProgressHUD
import Loaf

class BaseViewController<V>: UIViewController where V: ViewModelType {
    
    let viewModel: V
    
    let disposeBag = DisposeBag()
    
    private var progress: MBProgressHUD?
    
    required init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeKeyboardDismissable()
        bindToViewModel()
    }
    
    //have to override!
    func bindToViewModel() {
       fatalError("didn't bind viewmodel")
    }
    
    func showLoading(_ show: Bool) {
        self.view.isUserInteractionEnabled = !show
        hideProgressIfAlreadyShown()
        
        if show {
            progress = MBProgressHUD.showAdded(to: self.view, animated: true)
            progress!.mode = .indeterminate
            progress!.removeFromSuperViewOnHide = true
        }
    }
    
    func hideProgressIfAlreadyShown() {
        if progress != nil {
            progress?.hide(animated: true)
            progress = nil
        }
    }
    
    func showMessage(_ message: String) {
        Loaf(message, state: .info, sender: self).show(.short)
    }
    
    func showErrorMessage(_ message: String) {
        Loaf(message, state: .warning, sender: self).show(.short)
    }
    
    func makeKeyboardDismissable() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
