import Foundation
import Firebase
import AntourageViewer

final class FirePoll: Poll {
  private var ref: DocumentReference?
  private var answersListener: ListenerRegistration?
  private var userID: String?
  public var key: String
  public var userAnswer: Int?
  public var pollQuestion: String
  public var pollAnswers: [String]
  public var answersCount: [Int] {
    didSet {
      percentForEachAnswer = FirePoll.calculatePercentages(answersCount)
    }
  }
  
  public var onUpdate: (() -> ())?
  
  public var percentForEachAnswer: [Int] {
    didSet {
      self.onUpdate?()
    }
  }
  
  public init?(snapshot: DocumentSnapshot, userID: String?) {
    guard
      let value = snapshot.data(),
      let pollQuestion = value["question"] as? String,
      let pollAnswers = value["answers"] as? [String] else {
        return nil
    }
    self.userID = userID
    self.ref = snapshot.reference
    self.key = snapshot.documentID
    self.pollQuestion = pollQuestion
    self.pollAnswers = pollAnswers
    self.percentForEachAnswer = pollAnswers.map {_ in 0}
    self.answersCount = pollAnswers.map {_ in 0}
    if let userID = userID, userID == snapshot.documentID {
      self.userAnswer = value["chosenAnswer"] as? Int
    }
    answersListener = ref?.collection("answeredUsers").addSnapshotListener(answersHandler())
    
  }
  
  deinit {
    answersListener?.remove()
    print("Active poll deinited")
  }
  
  private static func calculatePercentages(_ pollAnswers: [Int]) -> [Int] {
    let sum = pollAnswers.reduce(0, +)
    if sum == 0 {
      return pollAnswers
    }
    let percentageArray = pollAnswers.map {100 * $0/sum}
    let arrayWithoutZero = percentageArray.filter {$0 != 0}
    let delta = percentageArray.reduce(100, -)
    if Set(arrayWithoutZero).count == 1 {
      return percentageArray
    }
    let firstElement = arrayWithoutZero[0]
    let number = arrayWithoutZero.dropFirst().contains(firstElement) ? arrayWithoutZero.first(where: {$0 != firstElement}) ?? firstElement : firstElement
    let count = arrayWithoutZero.filter {$0 == number}.count
    let a = delta/count
    return percentageArray.map {$0 == number ? $0 + a : $0}
  }
  
  private func answersHandler() -> FIRQuerySnapshotBlock {
    return { [weak self] (querySnapshot, error) in
      guard let documents = querySnapshot?.documents else {
        print("Error fetching documents: \(error!)")
        return
      }
      
      if let userID = self?.userID {
        let userDocument = documents.first(where: { $0.documentID == userID })
        self?.userAnswer = userDocument?.data()["chosenAnswer"] as? Int
      }
      let answers = documents.compactMap {$0.data()["chosenAnswer"] as? Int}
      let answersDict = Dictionary(grouping: answers, by: {$0})
      var result = [Int]()
      self?.pollAnswers.enumerated().forEach {
        let answersPerQuestion = answersDict[$0.offset]?.count
        result.append(answersPerQuestion ?? 0)
      }
      self?.answersCount = result
    }
  }
  
  func updateUserID(_ userID: String?) {
    self.userID = userID
  }
  
  public func saveAnswer(index: Int, userID: String) {
    ref?.collection("answeredUsers").document(userID).setData(["chosenAnswer": index, "timestamp": FieldValue.serverTimestamp()])
  }
}