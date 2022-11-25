//  WebSocket.swift
//  WebSocketDemo
//
//  Created by David Crooks on 07/09/2020.
//  Copyright © 2020 David Crooks. All rights reserved.
//

import Foundation
import Combine

//public struct ChatMessageIncoming: Codable {
//    var event = "message"
//    var data: ChatData
//
//    struct ChatData: Codable {
//        let from: String
//        let message: String
//    }
//}

public struct ChatMessageIncoming: Codable {
    var event = "message"
    var data: String
    var from: From
    
    struct From: Codable {
        let id: String
        let name: String
    }
}

public enum SocketData {
    case message(String)
    case outgoingMessage(Codable)
    //    case chatMessage(ChatMessage)
    case incomingMessage(ChatMessageIncoming)
    case uncodable(Data)
}

public final class CodableWebSocket: Publisher,Subscriber {
    
    public typealias Output = Result<SocketData,Error>
    public typealias Input =  SocketData
    public typealias Failure = Error
    let webSocketTask:URLSessionWebSocketTask
    public var combineIdentifier: CombineIdentifier = CombineIdentifier()
    
    public init(url:URL)
    {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with:url)
        webSocketTask.resume()
    }
    
    // MARK: Publisher
    
    public func receive<S>(subscriber: S) where S : Subscriber, CodableWebSocket.Failure == S.Failure, CodableWebSocket.Output == S.Input {
        let subscription = CodableWebsocketSubscription(subscriber: subscriber, socket:webSocketTask)
        subscriber.receive(subscription: subscription)
    }
    
    // MARK: Subscriber
    
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    public func receive(_ input: SocketData) -> Subscribers.Demand {
        let message:URLSessionWebSocketTask.Message
        
        switch input {
            
        case .message(let string):
            message = URLSessionWebSocketTask.Message.string(string)
        case .outgoingMessage(let codable):
            if let data = try? JSONEncoder().encode(codable) {
                message = URLSessionWebSocketTask.Message.data(data)
            }
            else {
                fatalError()
            }
        case .uncodable(let data):
            message = URLSessionWebSocketTask.Message.data(data)
        case .incomingMessage(_):
            fatalError("Can't send incoming message type")
        }
        
        webSocketTask.send(message, completionHandler: {
            error in
            if let error = error {
                if  self.webSocketTask.closeCode != .invalid {
                    //closed!
                }
                Swift.print("ERROR on send \(error)")
            }
        })
        return .unlimited
    }
    
    public func receive(completion: Subscribers.Completion<Error>) {
        Swift.print("Completion")
    }
    
}

extension CodableWebSocket {
    public func codable() -> AnyPublisher<ChatMessageIncoming, CodableWebSocket.Failure>
    {
        return compactMap { result -> ChatMessageIncoming? in
            guard case  Result<SocketData,Error>.success(let socketdata) = result,
                  case SocketData.message(let messageString) = socketdata
            else { return nil }
            let decoder = JSONDecoder()
            
            var chatMessage = ChatMessageIncoming(data: "", from: ChatMessageIncoming.From(id: "", name: ""))
            do {
                chatMessage = try decoder.decode(ChatMessageIncoming.self, from: Data(messageString.utf8))
            } catch {
                Swift.print(error.localizedDescription)
            }
             return chatMessage
        }.eraseToAnyPublisher()
    }
}

