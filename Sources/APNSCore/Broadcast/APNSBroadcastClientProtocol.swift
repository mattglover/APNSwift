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

/// Protocol defining the broadcast channel management operations.
public protocol APNSBroadcastClientProtocol: Sendable {
    /// Sends a broadcast channel management request.
    ///
    /// - Parameter request: The broadcast request to send.
    /// - Returns: A response containing the result.
    func send<Message: Encodable & Sendable, ResponseBody: Decodable & Sendable>(
        _ request: APNSBroadcastRequest<Message>
    ) async throws -> APNSBroadcastResponse<ResponseBody>
}
