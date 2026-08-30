local pinia = require(script.Parent)
local ref = pinia.state.ref
local computed = pinia.state.computed

local JestGlobals = require(script.Parent.DevPackages.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

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
        sumWithBase = function(self, n)
            self.angka.value = self.angka.value + n
        end
    }
})

-- setupStore test
describe("Setup store test", function()
    it("multiple angka", function()
        -- check if the computed func success
        expect(setupStore.multipleAngka).toBe(20)
        -- check if the computed func can save the recent value to the state
        expect(setupStore.angka.value).toBe(20)
    end)

    it("sum angka with n", function()
        setupStore.sumWithBase(1)
        expect(setupStore.angka.value).toBe(21)
    end)
end)

-- optStore test
describe("Option store test", function()
    it("multiple angka", function()
        -- check if the computed func success
        expect(optStore.multipleAngka).toBe(20)
        -- check if the computed func can save the recent value to the state
        expect(optStore.angka.value).toBe(20)
    end)

    it("sum angka with n", function()
        optStore.sumWithBase(1)
        expect(optStore.angka.value).toBe(21)
    end)
end)