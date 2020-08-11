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

public let tokamakStyles = """
._tokamak-stack > * {
  flex-shrink: 0;
}
._tokamak-scrollview-hideindicators {
  scrollbar-color: transparent;
  scrollbar-width: 0;
}
._tokamak-scrollview-hideindicators::-webkit-scrollbar {
  width: 0;
  height: 0;
}
._tokamak-list {
  list-style: none;
  overflow-y: auto;
  width: 100%;
  height: 100%;
  padding: 0;
}

._tokamak-disclosuregroup-label {
  cursor: pointer;
}
._tokamak-disclosuregroup-chevron-container {
  width: .25em;
  height: .25em;
  padding: 10px;
  display: inline-block;
}
._tokamak-disclosuregroup-chevron {
  width: 100%;
  height: 100%;
  transform: rotate(45deg);
  border-right: solid 2px rgba(0, 0, 0, 0.25);
  border-top: solid 2px rgba(0, 0, 0, 0.25);
}
._tokamak-disclosuregroup-content {
  display: flex;
  flex-direction: column;
  margin-left: 1em;
}

._tokamak-toolbar-container {
  width: 100%;
  height: 100%;
}
._tokamak-toolbar-container-toolbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 38px;
  padding: 10px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end;
}
._tokamak-toolbar-container-toolbar-item {
  flex-shrink: 1;
  flex-grow: 0;
}
._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item-navigation {
  margin-right: auto;
}
._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item {
  margin-left: auto;
}
._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item ~ ._tokamak-toolbar-container-toolbar-item {
  margin-left: unset;
}
._tokamak-toolbar-container-content > *:first-child:not(._tokamak-scrollview) {
  margin-top: 38px;
}
._tokamak-toolbar-container-content > ._tokamak-scrollview:first-of-type:before {
  content: '';
  height: 38px;
  display: block;
}

._tokamak-buttonstyle-reset {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  background: transparent;
  border: none;
  margin: 0;
  padding: 0;
  font-size: inherit;
}

._tokamak-text-redacted {
  position: relative;
}
._tokamak-text-redacted::after {
  content: " ";
  background-color: rgb(200, 200, 200);
  position: absolute;
  left: 0;
  width: calc(100% + .1em);
  height: 1.2em;
  border-radius: .1em;
}

._tokamak-navigationview {
  display: flex;
  flex-direction: row;
  align-items: stretch;
  width: 100%;
  height: 100%;
}
._tokamak-navigationview-content {
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  flex-grow: 1;
  height: 100%;
}
._tokamak-navigationview-body {
  width: 100%;
  height: 100%;
}
._tokamak-navigationview-with-toolbar > ._tokamak-navigationview-content {
  margin-top: 48px;
}
._tokamak-navigationview-with-toolbar > ._tokamak-toolbar-container {
  display: none;
}

._tokamak-securefield,
._tokamak-textfield-default,
._tokamak-textfield-roundedborder,
._tokamak-picker {
  color-scheme: light dark;
}

@media (prefers-color-scheme:dark) {
  ._tokamak-text-redacted::after {
    background-color: rgb(100, 100, 100);
  }

  ._tokamak-disclosuregroup-chevron {
    border-right-color: rgba(255, 255, 255, 0.25);
    border-top-color: rgba(255, 255, 255, 0.25);
  }

  ._tokamak-toolbar-container-toolbar {
    background-color: rgba(36, 36, 36, 0.5);
    border-bottom-color: rgba(255, 255, 255, 0.1);
  }
}
"""

public let rootNodeStyles = """
display: flex;
width: 100%;
height: 100%;
justify-content: center;
align-items: center;
overflow: hidden;
"""
