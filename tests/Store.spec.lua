local ReplicatedStorage = game:GetService("ReplicatedStorage")

local pinia = require(ReplicatedStorage.RoPinia)
-- local ref = pinia.state.ref
-- local computed = pinia.state.computed

local JestGlobals = require(ReplicatedStorage.RoPinia.DevPackages.JestGlobals)
local describe = JestGlobals.describe
local it = JestGlobals.it
local expect = JestGlobals.expect

-- example of stores
-- local setupStore = pinia.store.defineStoreSetup("SetupStore", function()
--     local hello = ref("World")
--     local angka = ref(10)

--     local multipleAngka = computed(function()
--         return angka.value * 2
--     end)

--     local helloWorldAct = function()
--         print(`Hello {hello}`)
--     end
--     local sumWithN = function(self, n)
--         self.angka.value += n
--     end

--     return {
--         hello = hello,
--         angka = angka,
--         multipleAngka = multipleAngka,
--         helloWorld = helloWorldAct,
--         sumWithN = sumWithN
--     }
-- end)

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

-- setupStore test
-- describe("Setup store test", function()
--     it("multiple angka", function()
--         -- check if the computed func success
--         expect(setupStore.multipleAngka.value).toBe(20)
--     end)

--     it("sum angka with n", function()
--         setupStore.sumWithN(1)
--         expect(setupStore.angka.value).toBe(11)
--         setupStore._reset()
--     end)

--     it("testing get _state", function()
--         expect(setupStore._state.angka.value).toBe(10)
--     end)

--     it("testing _reset store", function()
--         setupStore.angka.value += 10
--         expect(setupStore.angka.value).toBe(20)
--         setupStore._reset()
--         expect(setupStore.angka.value).toBe(10)
--     end)

--     it("testing _patch store", function()
--         setupStore._patch(function(state)
--             state.angka.value = 20
--         end)
--         expect(setupStore.angka.value).toBe(20)
--     end)
-- end)

-- myStore test
describe("Setup store test", function()
    it("multiple angka", function()
        -- check if the computed func success
        expect(myStore.multipleAngka.value).toBe(20)
    end)

    it("sum angka with n", function()
        myStore.sumWithN(1)
        expect(myStore.angka.value).toBe(11)
        myStore._reset()
    end)

    it("testing get _state", function()
        expect(myStore._state.angka.value).toBe(10)
    end)

    it("testing _reset store", function()
        myStore.angka.value += 10
        expect(myStore.angka.value).toBe(20)
        myStore._reset()
        expect(myStore.angka.value).toBe(10)
    end)

    it("testing _patch store", function()
        myStore._patch(function(state)
            state.angka.value = 20
        end)
        expect(myStore.angka.value).toBe(20)
    end)
end)