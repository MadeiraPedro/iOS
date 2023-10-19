//
//  URLSessionRequest.swift
//  Reminder
//
//  Created by Pedro Madeira on 03/10/23.
//

import Foundation
import UIKit

public class URLSessionRequest {
    
    public enum ServiceError: Error {
        case invalidURL
        case network(Error?)
        case decodeError(Error)
    }

    //MARK: - GET
    
    public func get<ResponseType: Codable>(string: String?, response: ResponseType.Type, completion: @escaping (Result<ResponseType, ServiceError>) -> Void) {
        let baseURL = "https://viacep.com.br/ws"
        let path = "/\(string ?? "")/json"
        
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(.invalidURL))
            return
        }
        print("\n\nEndPoint: \(url)\n")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(.network(error)))
                return
            }
            
            print("\n<--------- START JSON ---------> ")
            print(String(data: data, encoding: .utf8) ?? "")
            print(">--------- END JSON ---------<\n")
            
            do {
                let json = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(.success(json))
                //voltar para a main thread
            } catch {
                completion(.failure(.decodeError(error)))
            }
        }
        task.resume()
    }
    
    //MARK: - POST
    
    func post(_ body: URLSessionPostBody) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.timeoutInterval = 20
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        }catch let jsonErr{
            print(jsonErr)
        }
        
        //MARK: Make request
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                print(error ?? "")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(URLSessionPostBody.self, from: data)
                print("\n===== POST SUCCESSFULLY =====")
                print(response)
                print(String(data: data, encoding: .utf8) ?? "")
                print("=============================\n")
            }
            catch {
                print("\n===== POST ERROR =====")
                print(error)
                print("======================\n")
            }
        }
        task.resume()
    }
    
    //MARK: - DELETE
    
    func delete() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        struct testeJson: Codable {
            public var id: String
            public var title: String
            public var body: String
        }
        
        let requestBody = testeJson(id: "1", title: "João e o pe de feijão", body: "joao ficou muito rico")
        
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        }catch let jsonErr{
            print(jsonErr)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                print(error!)
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            print("\n===== DELETE SUCCESSFULLY =====")
            print("Status Code: \(response.statusCode)")
            print("=============================\n")
            
        }.resume()
    }
    
    //MARK: - PUT
    
    func put() {
        guard let url = URL(string: "https://reqres.in/api/users/2") else {
            print("Error: cannot create URL")
            return
        }
        
        let putBody = URLSessionPutBody(firstName: "Pedro", lastName: "Madeira", email: "pedromadeira@email.com")
        
        guard let jsonData = try? JSONEncoder().encode(putBody) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                
                print("\n========== PUT SUCCESSFULLY ==========")
                print(String(data: jsonData, encoding: .utf8) ?? "")
                print("======================================\n")
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
}


