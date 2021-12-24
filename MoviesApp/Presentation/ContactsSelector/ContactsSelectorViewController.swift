//
//  ContactsSelectorViewController.swift
//  MoviesApp
//
//  Created by jorgehc on 5/27/19.
//  Copyright 2019 jorgehc.com. All rights reserved.
//

import UIKit

class ContactsSelectorViewController: BaseViewController {

    //MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonActionViewContainer: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectionInstructionsLabel: UILabel!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedContactsCollectionView: UICollectionView! {
        didSet {
            setupCollectionView()
        }
    }
    @IBOutlet weak var buttonContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }

    //MARK: - Variables

    private let buttonContainerBottomHeight: CGFloat = 30.0
    private let buttonBottomConstraintValue: CGFloat = 2.0
    var keyboardIsShown: Bool = false
    internal var contactsHashed: [String: [ContactStruct]] = [:]
    internal var sortedKeys: [String] = []
    internal var paginatedContactsHashed: [String: [ContactStruct]] = [:]
    internal var paginatedContactsCopy: [String: [ContactStruct]] = [:]
    internal var paginatedSortedKeys: [String] = []
    internal var selectedContacts:[ContactStruct] = []
    internal var isPayment = false
    internal var isGroupAddSelection = false
    internal var isGroupCreationSelection = false
    internal var groupId: String?
    internal var preselectedMembers: [MembershipStruct] = []
    var presenter:  ContactsSelectorViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ContactsSelectorPresenter(view: self,
                                              groupService: isGroupAddSelection ? GroupsAPI() : nil )
        setupViews()
        if !isPayment {
            presenter.loadContactsFromDatabase(with: preselectedMembers)
        }
        setupGestureRecognizers()
        selectedContactsCollectionView.isHidden = true
        if (DeviceType.IS_IPHONE_5) {
            buttonContainerHeight.constant = 54
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if isPayment {
            presenter.loadContactsFromDatabase(with: preselectedMembers)
            updateViewsAfterContactSelection(contactsSelected: [ContactStruct]())
            reloadContactsTable()
        }
    }

    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGesture.numberOfTapsRequired = 1
        initializeScrollKeyboardEvents()
        self.searchBar.delegate = self
        let defaultTextAttribs: [String : Any] =
            [NSAttributedString.Key.font.rawValue:
                UIFont.custom(named: .circularStdBook).withSize(16)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary(defaultTextAttribs)
        nextButton.isHidden = true
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        navigationController?.isNavigationBarHidden = false
        title = isPayment ?  .send : .request
        if isGroupCreationSelection {
            title = .createGroup
        }
        selectionInstructionsLabel.text =  isPayment ? .chooseContactsToSend : selectionInstructionsLabel.text
        if isGroupCreationSelection {
            selectionInstructionsLabel.text = .chooseGroupToSend
        }
        if self.isGroupAddSelection {
            title = .add
            selectionInstructionsLabel.text = .chooseContactsToAdd
        }
        setBoldNavigationTitle(title ?? .empty)
        setupNextButtonViews()
    }


    func setupNextButtonViews() {
        nextButtonBottomConstraint.constant = DeviceType.IS_IPHONE_X_XS || DeviceType.IS_IPHONE_XR_XSMAX ? buttonContainerBottomHeight : buttonBottomConstraintValue
        buttonActionViewContainer.isHidden = true
        if self.isGroupAddSelection {
            self.nextButton.titleLabel?.text = .add
        }
    }

    func updateNextButtonViews(displayViews: Bool) {
        buttonActionViewContainer.isHidden = displayViews
        nextButton.isHidden = displayViews
    }

    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func nextButtonAction() {
        if isPayment {
            let paymentController = Navigator.get(controller: .payment, from: .payment) as? PaymentViewController
            guard let controller = paymentController else { return }
            controller.makeNavigationBarTransparent()
            controller.contactId = selectedContacts[0].id
            controller.contactName = selectedContacts[0].name
            self.navigationController?.pushViewController(controller, animated: true)
        } else if isGroupAddSelection {
            presenter.sendInviteGroup(groupId: groupId!, contacts: selectedContacts)
        } else if isGroupCreationSelection {
            presenter.sendToNewGroup(contacts: selectedContacts)
        } else {
            presenter.sendToChargeRequest()
        }
    }

    func setupGestureRecognizers() {
        let tableviewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapInsideContactsTableview(sender:)))
        tableviewTapGestureRecognizer.numberOfTapsRequired = 1
        tableviewTapGestureRecognizer.isEnabled = true
        tableviewTapGestureRecognizer.cancelsTouchesInView = false
        tableviewTapGestureRecognizer.delegate = self
        tableView.addGestureRecognizer(tableviewTapGestureRecognizer)
    }

    @objc func tapInsideContactsTableview(sender: UITapGestureRecognizer) {
        if searchBar.isFirstResponder {
            searchBar.endEditing(true)
            sender.cancelsTouchesInView = true
        } else {
            sender.cancelsTouchesInView = false
        }
    }
}

//MARK: - UI Setup
extension ContactsSelectorViewController {
    /// Handles search changes
    func filterContacts(with nameFilter: String) {
        contactsIterator: for key in String.alphabet {
            if let contacts = contactsHashed[String(key)] {
                for contact in contacts {
                    let contactIdentifier = "\(contact.name.diacriticInsensitive())\(contact.phone)"
                    if contactIdentifier.lowercased().contains(nameFilter.lowercased().diacriticInsensitive()) {
                        if paginatedContactsHashed[String(key)] == nil {
                            paginatedContactsHashed[String(key)] = []
                            paginatedSortedKeys.append(String(key))
                        }
                        paginatedContactsHashed[String(key)]?.append(contact)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func reloadContactsTable() {
        paginatedSortedKeys = sortedKeys
        paginatedContactsCopy = contactsHashed
        paginatedContactsHashed = paginatedContactsCopy
        tableView.reloadData()
    }

    func searchContactsLocally(nameFilter: String) {
        if !contactsHashed.isEmpty {
            resetContactsDictionaryAndKeys()
            if nameFilter == .empty {
                reloadContactsTable()
            } else {
                filterContacts(with: nameFilter)
            }
        }
    }
}

extension ContactsSelectorViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContactsLocally(nameFilter: searchText)
    }
}

extension ContactsSelectorViewController: ContactsSelectorView {
    func displayContacts(_ contacts: [String : [ContactStruct]], with keys: [String]) {
        contactsHashed = contacts
        sortedKeys = keys
        resetContactsDictionaryAndKeys()
        reloadContactsTable()
        sortedKeys = keys
        tableView.setEmpty(message: .empty)
        self.searchBar.isUserInteractionEnabled = true
    }

    func displayEmptyContactsView() {
        tableView.setEmpty(message: .noLocalContacts)
        sortedKeys = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayGroupDetail() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationsID.reloadGroupDetail.rawValue), object: self)
        DispatchQueue.main.async {
            self.navigationController?.popToViewController(expectedClassForCoder: GroupDetailViewController.classForCoder())
        }
    }
    
    func displayGroupName() {
        let createGroupController = Navigator.get(controller: .createGroup, from: .createGroup) as? CreateGroupViewController
        guard let controller = createGroupController else { return }
        controller.multipleRequest = MultipleRequest(contacts: selectedContacts, concept: .empty, amount: .zero, willCreateGroup: true, groupName: .empty)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func displayChargeRequest() {
        let chargeController = Navigator.get(controller: .charge, from: .charge) as? ChargeViewController
        guard let controller = chargeController else { return }
        if selectedContacts.count > 1 {
            controller.isMultipleCharge = true
            controller.multipleRequest = MultipleRequest(contacts: selectedContacts, concept: .empty, amount: .zero, willCreateGroup: false, groupName: .empty)
        } else {
            controller.contactId = selectedContacts[0].id
            controller.contactName = selectedContacts[0].name
        }

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func updateViewsAfterContactSelection(contactsSelected: [ContactStruct]) {
        selectedContacts = contactsSelected
        let contactsSelectedEmpty = contactsSelected.count == 0
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.selectedContactsCollectionView.isHidden = contactsSelectedEmpty
        })
        updateNextButtonViews(displayViews: contactsSelectedEmpty)
        selectedContactsCollectionView.reloadData()
        if (!keyboardIsShown) {
            updateTableViewBottomInset(contactsSelectedEmpty: contactsSelectedEmpty)
        }
        if isPayment && selectedContacts.count == 1 {
            nextButtonAction()
        }
    }

    func updateTableViewBottomInset(contactsSelectedEmpty: Bool) {
        let tableViewBottomInset =  DeviceType.IS_IPHONE_X_XS || DeviceType.IS_IPHONE_XR_XSMAX ? buttonContainerBottomHeight + 10.0 : nextButton.frame.height + 10.0
        if contactsSelectedEmpty {
            tableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        } else {
            tableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: tableViewBottomInset, right: 0.0)
            tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: tableViewBottomInset, right: 0.0)
        }
    }

    func cleanSearchText() {
        searchBar.text = .empty
    }

    func resetContactsDictionaryAndKeys() {
        paginatedContactsHashed = [:]
        paginatedSortedKeys = []
    }
}

//MARK: - KeyboardEvents
extension ContactsSelectorViewController {
    private func initializeScrollKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillBeShown(notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        let keyBoardSize = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        tableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyBoardSize.height + nextButton.frame.height, right: 0.0)
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyBoardSize.height + nextButton.frame.height, right: 0.0)
        nextButtonBottomConstraint.constant = keyBoardSize.height + buttonBottomConstraintValue
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        keyboardIsShown = true
    }

    @objc private func keyboardWillBeHidden() {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = tableView.contentInset
        keyboardIsShown = false
        nextButtonBottomConstraint.constant = DeviceType.IS_IPHONE_X_XS || DeviceType.IS_IPHONE_XR_XSMAX ? buttonContainerBottomHeight : buttonBottomConstraintValue
        updateTableViewBottomInset(contactsSelectedEmpty: selectedContacts.count == 0)
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
