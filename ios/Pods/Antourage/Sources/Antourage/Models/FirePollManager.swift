import Foundation
import Firebase
import AntourageViewer

final class FirePollManager: PollManager {
  private var streamId: Int
  private var path: String
  private  var pollListener: ListenerRegistration?
  
  public init(streamId: Int, path: String) {
    self.streamId = streamId
    self.path = path
  }
  
  func observePolls(userID: String?, completion: @escaping((Poll?) -> ())) {
    let app = FirebaseApp.app(name: "AntViewerFirebase")!
    let ref = Firestore.firestore(app: app).collection(path)
    
    pollListener = ref.whereField("isActive", isEqualTo: true).addSnapshotListener( { (querySnapshot, error) in
      guard let document = querySnapshot?.documents.first else {
        print("Error fetching documents or empty")
        completion(nil)
        return
      }
      if let newPoll = FirePoll(snapshot: document, userID: userID) {
        completion(newPoll)
      }
    })
  }
  
  func removeFirebaseObserver() {
    pollListener?.remove()
    pollListener = nil
  }
}
