    //
    //  onThemapClient.swift
    //  onTheMap3
    //
    //  Created by sid almekhlfi on 27/05/2020.
    //  Copyright © 2020 saeed almekhlfi. All rights reserved.
    //
    
    import Foundation
    
    
    class onThemapClient {
        
        struct Auth {
            static var Key = ""
            static var registered = false
            static var id = ""
            static var expiration = ""
        }
        
        enum Endpoint {
            case getStudensLoctions
            case createStudentLocation
            case logIn
            case logOut
            case inOrder
            var stringValue : String {
                
                switch self {
                case .getStudensLoctions:return "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt"
                case .createStudentLocation:return "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100"
                case .logIn:return "https://onthemap-api.udacity.com/v1/session"
                case .logOut:return "https://onthemap-api.udacity.com/v1/sessio"
                case .inOrder:return "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100&order=-updatedAt"
                    
                }
                
            }
            
            var url: URL {
                return URL(string:stringValue)!
            }
        }
        
        
        
        class func taskForPostRequset<ResponType:Decodable , RequestType:Encodable>(url:URL , body:RequestType ,ResponTypes:ResponType.Type, completion:@escaping(ResponType?,Error?)->Void){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONEncoder().encode(body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else{
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                    
                    return
                }
                
                let decoder = JSONDecoder()
                do{
                    
                    let responeObejct = try decoder.decode(ResponType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responeObejct,nil)
                        
                    }
                    
                } catch {
                    do {
                        var newData = data
                        let range = 5..<data.count
                        newData = data.subdata(in: range)
                        let errorResponse = try JSONDecoder().decode(UdacityResponse.self, from: newData)
                        DispatchQueue.main.async {
                            completion(nil,errorResponse)
                        }
                        
                        
                    } catch {
                        print("wrong")
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(nil,error)
                        }
                        
                    }
                }
                
            }
            
            task.resume()
            
            
            
            
        }
        class func taskForGetRequest<ResponType:Decodable>(url:URL , ResonseTypys:ResponType.Type, completion : @escaping(ResponType?,Error?)->Void){
            
            let task = URLSession.shared.dataTask(with: Endpoint.getStudensLoctions.url) { data , reesonse , error in
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion( nil, error)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    
                    let ResponseObject = try decoder.decode(ResponType.self, from: data)
                    DispatchQueue.main.async {
                        completion(ResponseObject , nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(nil , error)
                    }
                }
                
            }
            task.resume()
        }
        
        class func logOut(completion:@escaping ()->Void){
            var request = URLRequest(url: Endpoint.logOut.url)
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body =  LogoutRequest(session:LogoutRequest.session(id: self.Auth.id, expiration: self.Auth.expiration))
            request.httpBody = try! JSONEncoder().encode(body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                Auth.id = ""
                Auth.expiration = ""
                completion()
            }
            
            task.resume()
        }
        class func logIn(username:String,password:String,completion:@escaping(Bool,Error?)->Void) {
            var request = URLRequest(url: Endpoint.logIn.url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let body = LoginRequest(udacity: LoginRequest.Udacity(username: username, password: password))
            request.httpBody = try! JSONEncoder().encode(body)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else{
                    DispatchQueue.main.async {
                         completion(false,error)
                    }
                    return
                }
                 let decoder = JSONDecoder()
                do {
                   var newData = data
                    let rang = 5..<data.count
                    newData = data.subdata(in: rang)
                   let responObject = try decoder.decode(LoginResponse.self, from: newData)
                    
                    DispatchQueue.main.async {
                          completion(responObject.account.registered, nil)
                    }
                  
                }
              catch {
                    do {
                        var newData = data
                        let range = 5..<data.count
                        newData = data.subdata(in: range)
                        let errorResponse = try JSONDecoder().decode(UdacityResponse.self, from: newData)
                        DispatchQueue.main.async {
                            completion(false,errorResponse)
                        }
                        
                        
                    } catch {
                        print("wrong")
                        print(error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(false,error)
                        }
                        
                    }
                }
                
                
                
            }
            
            task.resume()
            
        }
        
        class func createStudentLocation(firstName:String,lastName:String,latitude:Double,longitude:Double ,mapString:String,uniqueKey:String,mediaURL:String, completion : @escaping (responseForCstudentLocation?,Error?)->Void){
            
            let body = StudentLocation(uniqueKey: uniqueKey, firstName: firstName, lastName: lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude)
            taskForPostRequset(url: Endpoint.createStudentLocation.url, body:body, ResponTypes:responseForCstudentLocation.self) { (response, error) in
                if let response = response {
                    completion(response, nil)
                } else{
                    completion(nil,error)
                }
            }
            
        }
        
        class func getStudents(completion : @escaping ([StudentLocationsDetail], Error?)-> Void ){
            taskForGetRequest(url: Endpoint.getStudensLoctions.url, ResonseTypys: LoactionsResults.self) { (response, error) in
                if let response = response {
                    completion(response.results,nil)
                    
                } else {
                    completion([] ,error)
                }
                
                
                
            }
            
         
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
