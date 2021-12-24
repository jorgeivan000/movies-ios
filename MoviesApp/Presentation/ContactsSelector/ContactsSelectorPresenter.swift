//
//  ContactsSelectorPresenter.swift
//  MoviesApp
//
//  Created by jorgehc on 5/27/19.
//  Copyright © 2019 jorgehc.com. All rights reserved.
//

import Foundation

class ContactsSelectorPresenter: ContactsSelectorViewPresenter {
    let view: ContactsSelectorView!
    var groupService: GroupsAPIProtocol?
    
    required init(view: ContactsSelectorView, groupService: GroupsAPIProtocol?) {
        self.view = view
        self.groupService = groupService
    }
    
    func loadContactsFromDatabase(with preselectedMemberships: [MembershipStruct]) {
        self.view.cleanSearchText()
        let realmManager = RealmManager.init()
        realmManager.getRecentContactsDictionaryWithKeys(onComplete: { [weak self] contactsDictionary, sortedKeys in
            guard let self = self else { return }
            var dictionary: [String: [ContactStruct]] = [:]
            var keys: [String] = []
            
            if contactsDictionary.isEmpty {
                self.view.displayEmptyContactsView()
                return
            }
            if !preselectedMemberships.isEmpty {
                contactsIterator: for key in String.alphabet {
                    if let contacts = contactsDictionary[String(key)] {
                        for contact in contacts {
                            if preselectedMemberships.filter({$0.contactId == contact.id}).first == nil {
                                if dictionary[String(key)] == nil {
                                    dictionary[String(key)] = []
                                    keys.append(String(key))
                                }
                                dictionary[String(key)]?.append(contact)
                            }
                        }
                    }
                }
            } else {
                dictionary = contactsDictionary
                keys = sortedKeys
            }
            self.view.displayContacts(dictionary, with: keys)
        })
    }
    
    func updateContactsSelected(contactsSelected: [ContactStruct]) {
        self.view.updateViewsAfterContactSelection(contactsSelected: contactsSelected)
    }
    
    func sendInviteGroup(groupId: String, contacts: [ContactStruct]) {
        let contactsIds = contacts.map{$0.id}
        groupService?.inviteGroup(groupId: groupId, contactsIds:contactsIds, completion: { [weak self] (group, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.view.display(error)
                return
            }
            self.view.displayGroupDetail()
        })
    }
    
    func sendToNewGroup(contacts: [ContactStruct]) {
        view.displayGroupName()
    }
    
    func sendToChargeRequest() {
        view.displayChargeRequest()
    }
    
}
