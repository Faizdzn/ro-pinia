local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed

local setupStore = pinia.store.defineStoreSetup("e", function()
    local hello = ref("World")
    local angka = ref(10)

    local multipleAngka = computed(function()
        angka.value = angka.value * 2
        return angka.value
    end)

    local helloWorldAct = function()
        print(`Hello {hello}`)
    end
    local sumWithBase = function(n)
        angka.value = angka.value * n
    end

    return {
        hello = hello,
        angka = angka,
        multipleAngka = multipleAngka,
        helloWorld = helloWorldAct,
        sumWithBase = sumWithBase
    }
end)

local optStore = pinia.store.defineStoreOpt("es", {
    state = function()
        return {
            hello = "World",
            angka = 10
        };
    end,
    getters = {
        multipleAngka = function(state)
            state.angka.value = state.angka.value * 2
            return state.angka.value
        end
    },
    actions = {
        helloWorld = function(self)
            print(`Hello {self.hello.value}`)
        end,
        sumWithBase = function(self, n)
            self.angka.value = self.angka.value + n
        end
    }
})

print(setupStore)
-- setupStore.helloWorld()
print(setupStore.multipleAngka)
print(setupStore.angka.value)

print(optStore)
-- optStore.helloWorld()
print(optStore.multipleAngka)
print(optStore.angka.value)