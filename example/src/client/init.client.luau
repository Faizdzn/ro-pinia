local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed

-- example of stores
local setupStore = pinia.store.defineStoreSetup("SetupStore", function()
    local hello = ref("World")
    local angka = ref(10)

    local multipleAngka = computed(function()
        angka.value = angka.value * 2
        return angka.value
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
            state.angka.value = state.angka.value * 2
            return state.angka.value
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

print("Opt Store")
print(optStore)
