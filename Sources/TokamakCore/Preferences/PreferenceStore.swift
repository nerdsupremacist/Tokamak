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

final class PreferenceStore {
  private(set) var values: [ObjectIdentifier: Any] = [:]
  var subjects: [ObjectIdentifier: CurrentValueSubject<Any, Never>] = [:]

  typealias PreferencePublisher<K> = Publishers.Map<CurrentValueSubject<Any, Never>, K.Value?>
    where K: PreferenceKey
  func subscribe<K>(to key: K.Type) -> PreferencePublisher<K>?
    where K: PreferenceKey
  {
    subjects[ObjectIdentifier(K.self)]?.map { $0 as? K.Value }
  }

  func setValue<K>(_ value: K.Value, forKey key: K.Type)
    where K: PreferenceKey
  {
    let id = ObjectIdentifier(key)
    values[id] = value as Any
    subjects[id]?.send(value as Any)
  }

  func value<K>(forKey key: K.Type) -> K.Value
    where K: PreferenceKey
  {
    // swiftlint:disable:next force_cast
    (values[ObjectIdentifier(key)] ?? K.defaultValue) as! K.Value
  }

  init() {}
}
