// Copyright 2020 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//  Created by Carson Katri on 8/11/20.
//

import CombineShim

public final class PreferenceStore {
  private(set) var values: [ObjectIdentifier: [Any]]
  private(set) var subjects: [ObjectIdentifier: CurrentValueSubject<Any, Never>]
  /// This allows for a separation when branches occur in the view tree.
  /// The branch can send its preference changes to the parent, but sibling branches won't send to other siblings.
  private(set) var parentSubjects: [[ObjectIdentifier: CurrentValueSubject<Any, Never>]]

  typealias PreferencePublisher<K> = Publishers.Map<CurrentValueSubject<Any, Never>, K.Value?>
    where K: PreferenceKey
  func subscribe<K>(to key: K.Type) -> PreferencePublisher<K>?
    where K: PreferenceKey, K.Value: Equatable
  {
    let id = ObjectIdentifier(K.self)
    if let subject = subjects[id] {
      return subject.map { $0 as? K.Value }
    } else {
      subjects[id] = CurrentValueSubject(value(forKey: key) as Any)
      return subjects[id]?.map { $0 as? K.Value }
    }
  }

  func setValue<K>(_ value: K.Value, forKey key: K.Type)
    where K: PreferenceKey
  {
    let id = ObjectIdentifier(key)
    var valueList = values[id] ?? [Any]()
    valueList.append(value)
    values[id] = valueList
    if let res = self.value(forKey: key) {
      subjects[id]?.send(res as Any)
      parentSubjects.forEach { $0[id]?.send(res as Any) }
    }
  }

  func value<K>(forKey key: K.Type) -> K.Value?
    where K: PreferenceKey
  {
    // swiftlint:disable:next force_cast
    values[ObjectIdentifier(key)]?
      .compactMap { $0 as? K.Value }
      .reduce(into: K.defaultValue) { res, next in
        K.reduce(value: &res) { next }
      }
  }

  public init(_ values: [ObjectIdentifier: [Any]] = [:],
              _ subjects: [ObjectIdentifier: CurrentValueSubject<Any, Never>] = [:],
              parentSubjects: [[ObjectIdentifier: CurrentValueSubject<Any, Never>]] = [])
  {
    self.values = values
    self.subjects = subjects
    self.parentSubjects = parentSubjects
  }

  func branch() -> PreferenceStore {
    .init(
      values,
      parentSubjects: parentSubjects + [subjects]
    )
  }
}
