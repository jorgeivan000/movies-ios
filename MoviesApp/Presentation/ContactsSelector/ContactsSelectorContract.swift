//
//  ContactsSelectorContract.swift
//  MoviesApp
//
//  Created by jorgehc on 5/27/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

protocol ContactsSelectorView: BaseView {
    /**
     Display contacts in sections according to keys
     - Parameter contacts: array of Contacts to display
     - Parameter keys: string representing section keys
     */
    func displayContacts(
        _ contacts: [String: [ContactStruct]],
        with keys: [String]
    )
    
    /// Resets all variables related to pagination
    func resetContactsDictionaryAndKeys()
    
    //Update views when a contact is selected or unselected
    func updateViewsAfterContactSelection(contactsSelected: [ContactStruct])
    
    /// Display empty contacts view
    func displayEmptyContactsView()
    
    /// Display group detail view
    func displayGroupDetail()
    
    /// Display group name creation view
    func displayGroupName()
    
    /// Display charge request view
    func displayChargeRequest()
    
    /// Clean the search text
    func cleanSearchText()
}

protocol ContactsSelectorViewPresenter {
    init(view: ContactsSelectorView, groupService: GroupsAPIProtocol?)
    
    /**
     Load contacts from database and filter according to provider name filters.
     - Parameter preselectedMemberships: array of preselected members to hide on contacts
     */
    func loadContactsFromDatabase(with preselectedMemberships: [MembershipStruct])
    
    /// Execute update of contacts selected array when a contacts is checked or unchecked
    func updateContactsSelected(contactsSelected: [ContactStruct])
    
    /**
     Execute invite send action to current grou
     - Parameter groupId: current group to add contacts
     - Parameter contacts: array of contacts to add to group
    */
    func sendInviteGroup(groupId: String, contacts: [ContactStruct])
    
    /**
     Execute create new group
     - Parameter contacts: array of contacts to add to group
     */
    func sendToNewGroup(contacts: [ContactStruct])
    
    /// Execute send to charge request
    func sendToChargeRequest()
}
