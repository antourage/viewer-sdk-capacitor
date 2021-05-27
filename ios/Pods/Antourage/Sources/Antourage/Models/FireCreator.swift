import Foundation
import AntourageViewer

struct FireCreator: FirebaseCreator {
  func createPollManager(streamId: Int, path: String) -> PollManager {
    return FirePollManager(streamId: streamId, path: path)
  }
  
  func createChat(videoContent: VideoContent, path: String) -> Chat {
    return FireChat(videoContent: videoContent, path: path)
  }
  
  func createMessageFetcher(path: String) -> FirebaseFetcher {
    return MessageFetcher(path: path)
  }
}
