//
//  CardActivationViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 07/11/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

class CardActivationViewController: NotifiableBaseViewController {
    @IBOutlet weak var activationActionContainer: ActionsContainer!
    @IBOutlet weak var firstFourDigits: UITextField!
    @IBOutlet weak var secondFourDigits: UITextField!
    @IBOutlet weak var thirdFourDigits: UITextField!
    @IBOutlet weak var fourthFourDigits: UITextField!
    @IBOutlet weak var lineDivider: UIView!
    @IBOutlet weak var actionContainerBottomConstraint: NSLayoutConstraint!
    var debitCardOnReplacement = false
    var currentNIP: String = .empty
    
    //MARK: - Controller
    var presenter: CardActivationViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CardActivationPresenter(view: self, cardService: CardsAPI(), userService: UsersAPI(), nip: currentNIP)
        activationActionContainer.delegate = self
        initializeScrollKeyboardEvents()
        activationActionContainer.isMainButtonEnabled = false
        makeNavigationBarTransparent()
        self.navigationItem.hidesBackButton = true
        let customBackButton = UIBarButtonItem(image: UIImage(named: "arrowBack") , style: .plain, target: self, action: #selector(ChangeNIPViewController.backAction(sender:)))
        customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = customBackButton
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didChangeFirstFourDigits(_ sender: Any) {
        if firstFourDigits.text?.count == 4 {
            secondFourDigits.becomeFirstResponder()
        }
        updateLineDividerIfNeeded()
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        if let tabbedViewController = navigationController?.getStackedViewController(expectedClassForCoder: TabbedHomeViewController.classForCoder()) as? TabbedHomeViewController {
           tabbedViewController.defaultTabSelected = TabbedViews.card.rawValue
           navigationController?.popToViewController(tabbedViewController, animated: true)
       } else {
           guard let tabbedViewController = Navigator.get(controller: .home, from: .home) as? TabbedHomeViewController else { return }
           navigationController?.pushViewController(tabbedViewController, animated: true)
       }
    }
    
    @IBAction func didChangeSecondFourDigits(_ sender: Any) {
        if secondFourDigits.text?.count == 4 {
            thirdFourDigits.becomeFirstResponder()
        }
        updateLineDividerIfNeeded()
    }
    
    @IBAction func didChangeThirdFourDigits(_ sender: Any) {
        if thirdFourDigits.text?.count == 4 {
            fourthFourDigits.becomeFirstResponder()
        }
        updateLineDividerIfNeeded()
    }
    
    @IBAction func didChangeFourthFourDigits(_ sender: Any) {
        updateLineDividerIfNeeded()
    }
    
    func updateLineDividerIfNeeded() {
        if isCardNumberValid() {
            lineDivider.backgroundColor = UIColor.persimon
            activationActionContainer.isMainButtonEnabled = true
        } else {
            lineDivider.backgroundColor = UIColor.weakhaiti50
            activationActionContainer.isMainButtonEnabled = false
        }
    }
    
    func getCompleteCardNumber() -> String {
        return firstFourDigits.text! + secondFourDigits.text! + thirdFourDigits.text! + fourthFourDigits.text!
    }
    
    func isCardNumberValid() -> Bool {
        return getCompleteCardNumber().count == 16
    }
}

//MARK: - ActionsContainerDelegate
extension CardActivationViewController: ActionsContainerDelegate {
    func didTapMainButton() {
        presenter.activateCardWithNIP(cardNumber: getCompleteCardNumber(), nip: currentNIP)
    }
}

extension CardActivationViewController {
    private func initializeScrollKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillBeShown(notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let keyBoardSize = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        actionContainerBottomConstraint.constant = keyBoardSize.height * -1
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    @objc private func keyboardWillBeHidden() {
        actionContainerBottomConstraint.constant = 0.0
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

extension CardActivationViewController: CardActivationView {
    func sendToCardActivated() {
        if let cardTechnology = SessionManager().retrieve(key: .ensoCardTechnology), cardTechnology == EnsoCardTechnology.emv.rawValue {
            guard let contactlessCardActivatedViewController = Navigator.get(controller: .contactlessCardActivated, from: .contactlessCardActivated) as? ContactlessCardActivatedViewController else { return }
            contactlessCardActivatedViewController.debitCardOnReplacement = debitCardOnReplacement
            self.navigationController!.push(viewController: contactlessCardActivatedViewController)
        } else {
            guard let cardActivatedController = Navigator.get(controller: .cardActivated, from: .cardActivated) as? CardActivatedViewController else { return }
            self.navigationController!.push(viewController: cardActivatedController)
        }
    }
}
