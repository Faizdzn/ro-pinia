<img src="images/logo_single.svg" width="125px">

# RoPinia
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/roblox/react-lua/blob/main/LICENSE)
[![CI](https://github.com/Faizdzn/ropinia/actions/workflows/ci.yml/badge.svg)](https://github.com/Faizdzn/ropinia/actions/workflows/ci.yml)
[![Get it on Creator Store](images/link-creator-store.svg)](https://create.roblox.com/store/asset/)
[![Wally (external link)](images/link-wally.svg)](https://wally.run/package/faizdzn/ropinia)

A Pinia state management library ported into Roblox, bringing the simplicity and developer experience of Pinia to Roblox. If you're already familiar with Pinia, this library provides a familiar approach to creating stores, managing reactive state, and organizing application logic while being designed around Luau's type system and runtime.

## Example Usage
`init.client.lua:`
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed

-- example of stores
local setupStore = pinia.store.defineStoreSetup("SetupStore", function()
    local hello = ref("World")
    local angka = ref(10)

    local multipleAngka = computed(function()
        return angka.value * 2
    end)

    local helloWorldAct = function()
        print(`Hello {hello}`)
    end
    local sumWithN = function(n)
        angka.value += n
    end

    return {
        hello = hello,
        angka = angka,
        multipleAngka = multipleAngka,
        helloWorld = helloWorldAct,
        sumWithN = sumWithN
    }
end)

local optStore = pinia.store.defineStoreOpt("OptStore", {
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

print("Setup Store")
print(setupStore)
print(setupStore.angka.value)
print(setupStore.multipleAngka.value)

setupStore.angka.value = 11
setupStore.multipleAngka:recompute()
print(setupStore.angka.value)
print(setupStore.multipleAngka.value)

print("Opt Store")
print(optStore)
print(optStore.angka.value)
print(optStore.multipleAngka.value)

optStore.angka.value = 11
optStore.multipleAngka:recompute()
print(optStore.angka.value)
print(optStore.multipleAngka.value)

```

Check our official examples in [./example](https://github.com/Faizdzn/ropinia/tree/main/example) (Rojo)

## Contributors
<a href="https://github.com/Faizdzn/ropinia/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Faizdzn/ropinia" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

## Donate
If RoPinia is useful to you, consider supporting its development! Your support helps us maintain the project, improve existing features, fix bugs, and continue building useful open-source tools for the community. Every contribution, whether it's a sponsorship, donation, or simply sharing the project, is greatly appreciated.

[![Patreon](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fwww.patreon.com%2Fapi%2Fcampaigns%2F15749420&query=data.attributes.patron_count&suffix=%20Patrons&color=FF5441&label=Patreon&logo=Patreon&logoColor=FF5441&style=for-the-badge)](https://patreon.com/Faizdzn)