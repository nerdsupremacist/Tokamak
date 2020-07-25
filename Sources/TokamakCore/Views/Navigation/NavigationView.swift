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
//  Created by Jed Fox on 06/30/2020.
//

class NavigationContext: ObservableObject {
  @Published var destination: AnyView = AnyView(EmptyView())
  @Published var title: AnyView?
  @Published var toolbar: _AnyToolbarContainer?
}

/// A wrapper around the content of a `NavigationView` to allow `Renderer` overrides.
public struct _NavigationViewBody<Content>: View where Content: View {
  public let content: Content

  public var body: Never {
    neverBody("_NavigationViewBody")
  }
}

public struct NavigationView<Content>: View where Content: View {
  @ObservedObject var context = NavigationContext()
  let content: Content

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    print("Buidling navview")
    return _NavigationViewBody(content: HStack {
      content
      context.destination
    })
      .environmentObject(context)
  }
}

struct NavigationDestinationKey: EnvironmentKey {
  public static let defaultValue: Binding<AnyView>? = nil
}

struct NavigationToolbarKey: EnvironmentKey {
  public static let defaultValue: Binding<_AnyToolbarContainer?>? = nil
}

struct NavigationTitleKey: EnvironmentKey {
  public static let defaultValue: Binding<AnyView>? = nil
}

extension EnvironmentValues {
  var navigationDestination: Binding<AnyView>? {
    get {
      self[NavigationDestinationKey.self]
    }
    set {
      self[NavigationDestinationKey.self] = newValue
    }
  }

  var navigationToolbar: Binding<_AnyToolbarContainer?>? {
    get {
      self[NavigationToolbarKey.self]
    }
    set {
      self[NavigationToolbarKey.self] = newValue
    }
  }

  var navigationTitle: Binding<AnyView>? {
    get {
      self[NavigationTitleKey.self]
    }
    set {
      self[NavigationTitleKey.self] = newValue
    }
  }
}

public let _navigationDestinationKey = \EnvironmentValues.navigationDestination
public let _navigationToolbarKey = \EnvironmentValues.navigationToolbar
public let _navigationTitleKey = \EnvironmentValues.navigationTitle
