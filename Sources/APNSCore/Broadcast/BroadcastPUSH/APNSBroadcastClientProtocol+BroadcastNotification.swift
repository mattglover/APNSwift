import struct Foundation.UUID

extension APNSBroadcastClientProtocol {
    
    /// Sends a live activity notification.
    ///
    /// - Parameters:
    ///   - notification: The notification to send.
    ///
    ///   - deviceToken: The hexadecimal bytes use to send live activity notification. Your app receives the bytes for this activity token
    ///    from `pushTokenUpdates` async property of a live activity.
    ///
    ///
    ///   - logger: The logger to use for sending this notification.
    @discardableResult
    @inlinable
    
    public func sendBroadcastNotification<ContentState: Encodable & Sendable>(toChannel channelId: String, apnsTopic: String, contentState: ContentState, liveActivityEnded: Bool = true, apnsExpiry: APNSNotificationExpiration = .immediately, apnsPriority: APNSPriority = .immediately, apnsRequestID: UUID? = nil, dismissalDate: APNSBroadcastDismissalDate = .none) async throws -> APNSBroadcastResponse<EmptyPayload> {

        let request: APNSBroadcastRequest<ContentState>
        if liveActivityEnded {
            request = APNSBroadcastRequest<ContentState>(operation: .updateLiveActivityMessage(channelID: channelId, topic: apnsTopic), message: contentState, apnsRequestID: nil)
        } else {
            request = APNSBroadcastRequest<ContentState>(operation: .endLiveActivityMessage(channelID: channelId, topic: apnsTopic), message: contentState, apnsRequestID: nil)
        }
        
        return try await send(request)
    }
}

