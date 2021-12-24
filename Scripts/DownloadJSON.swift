import Foundation
import Files

enum Resources: String, CaseIterable {
    case user = "User"
    case paymentMethods = "PaymentMethod"
    case bankAccounts = "BankAccount"
    case contacts = "Contact"
    case cashouts = "Cashout"
    case messages = "Message"
}

let token = "AtFdwvF5NP62oE7v6LVM96Tc"
let apiURL = "https://dev-enso-core.herokuapp.com"
let dispatchGroup = DispatchGroup()

func downloadResourcesJSON() {
    for resource in Resources.allCases {
        var fileName = resource.rawValue
        var route = getRoute(resource)
        
        getResourceJSON(fileName, route)
    }
}

private func getRoute(_ resource: Resources) -> String {
    var route: String = ""
    
    switch resource {
    case .user:
        route = "/api/v1/users"
    case .paymentMethods:
        route = "/api/v1/accounts/payment_methods"
    case .bankAccounts:
        route = "/api/v1/accounts/bank_accounts"
    case .contacts:
        route = "/api/v1/contacts"
    case .cashouts:
        route = "/api/v1/accounts/transactions/withdrawal"
    case .messages:
        route = "/api/v1/contacts/chats"
    }
    return route
}

private func getResourceJSON(_ fileName: String, _ route: String) {
    dispatchGroup.enter()
    
    let url = URL(string: "\(apiURL)\(route)")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request){ data, response, error in
        guard(error == nil) else {
            print("\(error)")
            return
        }
        let parseResult: [String: AnyObject]!
        do{
            parseResult = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
            print("Parsing data: \(parseResult["data"])")
            if let data = data {
                // Write JSON file
                let resourceFolder = try Folder.current.subfolder(atPath: "EnsoTests/Resources")
                print("\(fileName) was downloaded")
                try resourceFolder.createFile(named: "\(fileName).json", contents: data)
                dispatchGroup.leave()
            }
        } catch {
            print("Could not parse data as JSON \(error)")
            dispatchGroup.leave()
        }
    }.resume()
}

downloadResourcesJSON()

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}
dispatchMain()



