local ReplicatedStorage = game:GetService("ReplicatedStorage")

local pinia = require(ReplicatedStorage.RoPinia)
local ref = pinia.state.ref
local computed = pinia.state.computed
local watch = pinia.state.watch

local JestGlobals = require(ReplicatedStorage.RoPinia.DevPackages.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

-- example of states
local angka = ref(10)
local tambahSatu = computed(function()
    return angka.value + 1
end)

-- ref test
describe("angka(ref<int>) test", function()
    it("output the value is same", function()
        expect(angka.value).toBe(10)
    end)
end)

-- computed test
describe("tambahSatu(computed<int>) test", function()
    it("output the value is plus 1", function()
        expect(tambahSatu.value).toBe(11)
    end)
end)

-- watch test
describe("watch angka", function()
    it("watch for changes", function()
        local newValue = nil
        watch(angka, function(_, newVal)
            newValue = newVal
        end)
        angka.value = 12
        
        task.wait(1)
        expect(newValue).toBe(12)
    end)
end)