local pinia = require(script.Parent)
local ref = pinia.state.ref
local computed = pinia.state.computed

local JestGlobals = require(script.Parent.DevPackages.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

-- example of ref
local angka = ref(10)
local tambahSatu = computed(function()
    return angka
end)

-- ref test
describe("angka(ref<int>) test", function()
    it("output the value is same", function()
        expect(angka.value).toBe(10)
    end)
end)

-- computed test
describe("tambahSatu(computed<int>) test", function()
    it("output the value is same", function()
        expect(tambahSatu.value).toBe(11)
    end)
end)