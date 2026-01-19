import struct Foundation.UUID

extension APNSBroadcastClientProtocol {
    /// Creates a new broadcast channel.
    ///
    /// - Parameters:
    ///   - channel: The channel configuration.
    ///   - apnsRequestID: An optional request ID for tracking.
    /// - Returns: The created channel information.
    public func create(
        channel: APNSBroadcastChannel,
        apnsRequestID: UUID? = nil
    ) async throws -> APNSBroadcastResponse<APNSBroadcastChannel> {
        let request = APNSBroadcastRequest<APNSBroadcastChannel>(
            operation: .createChannel,
            message: channel,
            apnsRequestID: apnsRequestID
        )
        return try await send(request)
    }

    /// Reads information about an existing broadcast channel.
    ///
    /// - Parameters:
    ///   - channelID: The ID of the channel to read.
    ///   - apnsRequestID: An optional request ID for tracking.
    /// - Returns: The channel information.
    public func read(
        channelID: String,
        apnsRequestID: UUID? = nil
    ) async throws -> APNSBroadcastResponse<APNSBroadcastChannel> {
        let request = APNSBroadcastRequest<EmptyPayload>(
            operation: .readChannel(channelID: channelID),
            message: nil,
            apnsRequestID: apnsRequestID
        )
        return try await send(request)
    }

    /// Deletes an existing broadcast channel.
    ///
    /// - Parameters:
    ///   - channelID: The ID of the channel to delete.
    ///   - apnsRequestID: An optional request ID for tracking.
    /// - Returns: An empty response.
    public func delete(
        channelID: String,
        apnsRequestID: UUID? = nil
    ) async throws -> APNSBroadcastResponse<EmptyPayload> {
        let request = APNSBroadcastRequest<EmptyPayload>(
            operation: .deleteChannel(channelID: channelID),
            message: nil,
            apnsRequestID: apnsRequestID
        )
        return try await send(request)
    }

    /// Lists all broadcast channel IDs.
    ///
    /// - Parameter apnsRequestID: An optional request ID for tracking.
    /// - Returns: A list of all channel IDs.
    public func readAllChannelIDs(
        apnsRequestID: UUID? = nil
    ) async throws -> APNSBroadcastResponse<APNSBroadcastChannelList> {
        let request = APNSBroadcastRequest<EmptyPayload>(
            operation: .listAllChannels,
            message: nil,
            apnsRequestID: apnsRequestID
        )
        return try await send(request)
    }
}
