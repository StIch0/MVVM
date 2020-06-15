//
//  AuthViewController.swift
//  MyProject
//
//  Created by Dev on 01.06.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import AuthenticationServices
import RxSwift
import RxCocoa

class AuthViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    var authViewModel: AuthViewModel!
    @IBOutlet weak var loginButton: UIButton!

    let disposeBag: DisposeBag = DisposeBag()

    let emailValidator: EmailValidator = EmailValidator()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        authViewModel = AuthViewModel()
        if #available(iOS 13.0, *) {
            let authView: UIView = UIView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50))
            let authorizationButton = ASAuthorizationAppleIDButton()
            authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
            self.view.addSubview(authView)
            authView.addSubview(authorizationButton)
        } else {

        }
        
        loginTextField
            .rx
            .text
            .orEmpty
            .bind(to: authViewModel.userEmail)
            .disposed(by: disposeBag)

        loginTextField
            .rx
            .text
            .orEmpty
            .map(emailValidator.validate(_:))
            .bind(to: authViewModel.isValidEmail)
            .disposed(by: disposeBag)

        authViewModel.bindLoginButton(tap: loginButton.rx.tap)

        self.view.backgroundColor = .white
    }


    @available(iOS 13.0, *)
    @objc
       func handleAuthorizationAppleIDButtonPress() {
           let appleIDProvider = ASAuthorizationAppleIDProvider()
           let request = appleIDProvider.createRequest()
           request.requestedScopes = [.fullName, .email]

           let authorizationController = ASAuthorizationController(authorizationRequests: [request])
           authorizationController.delegate = self
           authorizationController.presentationContextProvider = self
           authorizationController.performRequests()
       }
}
extension AuthViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)

            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            authViewModel.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)

        case let passwordCredential as ASPasswordCredential:

            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }

        default:
            break
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }

//    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
//        print(userIdentifier,fullName,email)
//    }

    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /// - Tag: did_complete_error
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

 extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
