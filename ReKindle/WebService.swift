//
//  WebService.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/17/21.
//

import Foundation
import Firebase

class WebService {
    static let shared = WebService()
    
    private let db = Firestore.firestore()
    
    func loginUser(username: String, password: String, completionHandler: @escaping ((Any?) -> Void)) {
        db.collection("users").getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err.localizedDescription)
            } else {
                if let snapshot = querySnapshot {
                    let loginUserSnapshot = snapshot.documents.filter {
                        let userData = $0.data()
                        return userData["username"] as? String == username
                    }.first
                    if var loginUserDetails = loginUserSnapshot?.data() {
                        if loginUserDetails["password"] as? String == password {
                            loginUserDetails["userId"] = loginUserSnapshot?.documentID ?? ""
                            completionHandler(loginUserDetails)
                        } else {
                            completionHandler("Password is incorrect")
                        }
                    } else {
                        completionHandler("Could not find user")
                    }
                }
            }
        })
    }
    
    func signUp(userDetails: [String: Any], completionHandler: @escaping ((String?, Bool) -> Void)) {
        checkUser(fieldName: "username", fieldValue: userDetails["username"] as? String ?? "", completionHandler: {(userExists) in
            if !(userExists ?? true) {
                var ref: DocumentReference? = nil
                ref = self.db.collection("users").addDocument(data: userDetails) {(error) in
                    if let err = error {
                        print("Error adding document: \(err)")
                        completionHandler(err.localizedDescription, false)
                    } else {
                        print("Document added with ID: \(ref?.documentID ?? "")")
                        completionHandler(ref?.documentID ?? "", true)
                    }
                }
            } else {
                completionHandler("Username is not unique", false)
            }
        })
    }
    
    func updateLocationToken(token: String, userId: String, completionHandler: ((Any?) -> Void)?) {
        let orderDocRef = db.collection("users").document(userId)
        orderDocRef.updateData(["locationToken": token], completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                if let handler = completionHandler {
                    handler(err)
                }
            } else {
                if let handler = completionHandler {
                    handler(nil)
                }
            }
        })
    }
    
    func checkUser(fieldName: String, fieldValue: String, completionHandler: @escaping ((Bool?) -> Void)) {
        print("get user details", fieldName, fieldValue)
        let userDocRef = db.collection("users").whereField(fieldName, isEqualTo: fieldValue)
        userDocRef.getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(nil)
            } else {
                if let snapshot = querySnapshot, snapshot.documents.count > 0 {
                    completionHandler(true)
                } else {
                    print("Document does not exist in cache")
                    completionHandler(false)
                }
            }
        })
    }
    
    func getUserDetails(userId: String, completionHandler: @escaping ((Any?) -> Void)) {
        let userDocRef = db.collection("users").document(userId)
        userDocRef.getDocument(completion: {(querySnapshot, err) in
            if let data = querySnapshot?.data() {
                print("User details: ", data)
                completionHandler(data)
            } else if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err.localizedDescription)
            }
        })
    }
    
    func newBook(bookData: [String: Any], completionHandler: @escaping ((Any?) -> Void)) {
        let bookDocRef = db.collection("books")
        bookDocRef.addDocument(data: bookData, completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func cancelServiceRequest(orderId: String, completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        orderDocRef.delete(completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func acceptServiceRequest(orderId: String, serverId: String, completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        orderDocRef.updateData(["serviceUserId": serverId, "displayStatus": "accepted", "status": "active"], completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func updateServerLocation(orderId: String, location: GeoPoint, completionHandler: ((Any?) -> Void)?) {
        let orderDocRef = db.collection("orders").document(orderId)
        orderDocRef.updateData(["serverLocation": location], completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                if let handler = completionHandler {
                    handler(err)
                }
            } else {
                if let handler = completionHandler {
                    handler(nil)
                }
            }
        })
    }
    
    func getUpdatedServerLocation(orderId: String, completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        orderDocRef.getDocument(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(nil)
            } else {
                if let document = querySnapshot {
                    if let data = document.data() {
                        completionHandler(data["serverLocation"] as? GeoPoint)
                    }
                } else {
                    completionHandler(nil)
                }
            }
        })
    }
    
    func declineServiceRequest(orderId: String, declinedIds: [String], completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        orderDocRef.updateData(["declinedBy": declinedIds], completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func winchRequestCompleted(orderId: String, completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        let updatedParams = ["displayStatus": "success", "status": "completed"]
        orderDocRef.updateData(updatedParams, completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func updateRatingReview(orderId: String, rating: Float, review: String, completionHandler: @escaping ((Any?) -> Void)) {
        let orderDocRef = db.collection("orders").document(orderId)
        let updatedParams: [String : Any] = ["rating": rating, "review": review]
        orderDocRef.updateData(updatedParams, completion: {(err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(err)
            } else {
                completionHandler(nil)
            }
        })
    }
    
    func getUserBooks(userId: String, completion: @escaping (([Book]?) -> Void)) {
        
        let bookQuery = db.collection("books").whereField("ownerId", isEqualTo: userId)
        
        bookQuery.getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                if let snapshot = querySnapshot {
                    var allBooks: [Book] = []
                    for document in snapshot.documents {
                        print("\(document.documentID) => \(document.data())")
                        var data = document.data()
                        data["id"] = document.documentID
                        allBooks.append(Book(details: data))
                    }
                    completion(allBooks)
                } else {
                    completion(nil)
                }
            }
        })
    }
}
