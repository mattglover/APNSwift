//===----------------------------------------------------------------------===//
//
// This source file is part of the APNSwift open source project
//
// Copyright (c) 2024 the APNSwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of APNSwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import struct Foundation.UUID

/// Represents a request to the APNs broadcast channel management API.
public struct APNSBroadcastRequest<Message: Encodable>: Sendable where Message: Sendable {
    /// The type of broadcast operation to perform.
    public enum Operation: Sendable {
        /// Create a new broadcast channel.
        case createChannel
        /// Read an existing broadcast channel.
        case readChannel(channelID: String)
        /// Delete an existing broadcast channel.
        case deleteChannel(channelID: String)
        /// List all broadcast channels.
        case listAllChannels
        
        case updateLiveActivityMessage(channelID: String, topic: String, priority: String = "10", expiration: String = "0")
        case endLiveActivityMessage(channelID: String, topic: String, priority: String = "10", expiration: String = "0")

        /// The HTTP method as a string.
        public var httpMethod: String {
            switch self {
            case .createChannel, .updateLiveActivityMessage, .endLiveActivityMessage:
                return "POST"
            case .readChannel, .listAllChannels:
                return "GET"
            case .deleteChannel:
                return "DELETE"
            }
        }

        /// The path for this operation.
        public var path: String {
            switch self {
            case .createChannel, .deleteChannel, .readChannel, .listAllChannels:
                return "/channels"
            case .updateLiveActivityMessage, .endLiveActivityMessage:
                return ""
            }
        }
        
        /// HTTP Headers for this operation.
        public var headers: [String: String]? {
            switch self {
            case .deleteChannel(let channelID), .readChannel(channelID: let channelID):
                return ["apns-channel-id": channelID]
            case  .updateLiveActivityMessage(let channelID, let topic, let priority, let expiration), .endLiveActivityMessage(let channelID, let topic, let priority, let expiration):
                return [
                    "apns-channel-id": channelID,
                    "apns-push-type": "liveactivity",
                    "apns-priority": priority,
                    "apns-expiration": expiration,
                    "apns-topic": topic
                ]
            default:
                return nil
            }
        }
    }

    /// The operation to perform.
    public let operation: Operation

    /// The message payload for operations that require a body (e.g., create).
    public let message: Message?

    /// An optional request ID for tracking.
    public let apnsRequestID: UUID?

    /// Creates a broadcast request.
    ///
    /// - Parameters:
    ///   - operation: The type of operation to perform.
    ///   - message: The message payload (required for create operations).
    ///   - apnsRequestID: An optional request ID for tracking.
    public init(
        operation: Operation,
        message: Message? = nil,
        apnsRequestID: UUID? = nil
    ) {
        self.operation = operation
        self.message = message
        self.apnsRequestID = apnsRequestID
    }
}
