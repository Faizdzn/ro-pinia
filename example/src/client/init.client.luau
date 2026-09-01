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

-- ===

local ref = pinia.state.ref
local computed = pinia.state.computed
local watch = pinia.state.watch

-- example of states
local angka = ref(10)
local tambahSatu = computed(function()
    return angka.value + 1
end)

watch(angka, function(_, newVal)
    print(newVal)
end)

print(angka.value)
print(tambahSatu.value)

angka.value = 12