local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed

local setupStore = pinia.store.defineStoreSetup("e", function()
    local HelloPinia = ref("Hello RoPinia!")
    local testRef = ref(10)
    local testCompute = computed(function()
        return testRef.value * 2
    end)

    return {
        hello = HelloPinia,
        testRef = testRef,
        testComp = testCompute
    }
end)

local optStore = pinia.store.defineStore("es", {
    state = function()
        return {
            hello = "World",
            angka = 10
        };
    end,
    getters = {
        multipleAngka = function(state)
            return state.angka * 2
        end
    },
    actions = {
        helloWorld = function(self)
            print(`Hello {self.hello.value}`)
        end,
        sumWithBase = function(self, n)
            return self.angka.value + n
        end
    }
})

print(setupStore)
-- setupStore.angka.value = 11
-- print(setupStore.helloWorld())
-- print(setupStore.sumWithBase(1))

print(optStore)