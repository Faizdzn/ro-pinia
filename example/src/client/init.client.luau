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
