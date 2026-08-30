local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed

local myNewStore: {
    hello: typeof(ref("")),
    testRef: typeof(ref(0)),
    testComp: typeof(ref(0))
} = pinia.store.defineStoreSetup("e", function()
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

print(myNewStore)
print(myNewStore.hello)
print(myNewStore.testRef)
print(myNewStore.testComp)