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

public protocol _AnyPreferenceKey {
  static var anyDefaultValue: Any { get }
}

public protocol PreferenceKey: _AnyPreferenceKey {
  associatedtype Value
  static var defaultValue: Value { get }
  static func reduce(value: inout Value, nextValue: () -> Value)
  static var _includesRemovedValues: Bool { get }
  static var _isReadableByHost: Bool { get }
}

extension PreferenceKey where Value: ExpressibleByNilLiteral {
  public static var defaultValue: Value { nil }
}

extension PreferenceKey {
  public static var _includesRemovedValues: Bool { false }
  public static var _isReadableByHost: Bool { false }
  static var anyDefaultValue: Any { defaultValue as Any }
}
