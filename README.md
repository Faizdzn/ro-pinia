<img src="images/logo_single.svg" width="125px">

# RoPinia
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/roblox/react-lua/blob/main/LICENSE)
[![CI](https://github.com/Faizdzn/ropinia/actions/workflows/ci.yml/badge.svg)](https://github.com/Faizdzn/ropinia/actions/workflows/ci.yml)
[![Get it on Creator Store](images/link-creator-store.svg)](https://create.roblox.com/store/asset/139280151381062)
[![Wally (external link)](images/link-wally.svg)](https://wally.run/package/faizdzn/ro-pinia)

A Pinia state management library ported into Roblox, bringing the simplicity and developer experience of Pinia to Roblox. If you're already familiar with Pinia, this library provides a familiar approach to creating stores, managing reactive state, and organizing application logic.

## Example Usage
`init.client.luau:`
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)

-- example of stores
local myStore = pinia.store.defineStore("myStore", {
    state = function()
        return {
            hello = "World",
            angka = 10
        };
    end,
    getters = {
        multipleAngka = function(state)
            return state.angka.value * 2
        end
    },
    actions = {
        helloWorld = function(self)
            print(`Hello {self.hello.value}`)
        end,
        sumWithN = function(self, n)
            self.angka.value += n
        end
    }
})

print("My Store")
print(myStore)
print(myStore.angka.value)
print(myStore.multipleAngka.value)

myStore.sumWithN(1)
myStore.multipleAngka:recompute()
print(myStore.angka.value)
print(myStore.multipleAngka.value)

```

Check our official examples in [./example](https://github.com/Faizdzn/ropinia/tree/main/example) (Rojo)

## Contributors
<a href="https://github.com/Faizdzn/ro-pinia/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Faizdzn/ro-pinia" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

## Donate
If RoPinia is useful to you, consider supporting its development! Your support helps us maintain the project, improve existing features, fix bugs, and continue building useful open-source tools for the community. Every contribution, whether it's a sponsorship, donation, or simply sharing the project, is greatly appreciated.

[![Patreon](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fwww.patreon.com%2Fapi%2Fcampaigns%2F15749420&query=data.attributes.patron_count&suffix=%20Patrons&color=FF5441&label=Patreon&logo=Patreon&logoColor=FF5441&style=for-the-badge)](https://patreon.com/Faizdzn)