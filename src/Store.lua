local PiniaTypes = require(script.Parent.types.Pinia)
local StateTypes = require(script.Parent.types.State)

local Signal = require(script.Parent.Packages.Signal)
local PiniaState = require(script.Parent.VueState)

local computed = PiniaState.computed
local ref = PiniaState.ref

local defineStore: PiniaTypes.defineStoreOpt = function(storeId, properties)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    
    local state = properties.state()
    if state ~= nil then
        local StoreValue = {
            storeId = storeId
        }
        local subcribeSignal = Signal.new()

        local StateLinked = {}
        for key, value in state do
            StoreValue[key] = ref(value)
            StateLinked[key] = StoreValue[key]
        end

        local ComputedLinked = {}
        for key, value in properties.getters do
            StoreValue[key] = computed(function()
                return value(StateLinked)
            end)
            ComputedLinked[key] = StoreValue[key]
        end

        for key, value in properties.actions do
            StoreValue[key] = function(props: any | nil)
                return value(StoreValue, props)
            end
        end

        StoreValue._state = StateLinked
        StoreValue._getters = ComputedLinked
        StoreValue._reset = function()
            for key, value in state do
                StoreValue[key] = ref(value)
                StateLinked[key] = StoreValue[key]
            end
        end
        StoreValue._patch = function(patchFunc: (state: {[string]: StateTypes.Ref<any>}) -> nil)
            patchFunc(StateLinked)

            subcribeSignal:Fire({
                storeId = StoreValue.storeId
            }, StateLinked)
        end
        StoreValue._subcribe = function(subcribeFunc: (mutate: PiniaTypes.MutateTable, state: {[string]: StateTypes.Ref<any>}) -> nil)
            subcribeSignal:Connect(subcribeFunc)
        end

        return StoreValue
    else
        return nil
    end
end

-- local defineStoreSetup: PiniaTypes.defineStoreSetup = function(storeId, setupFunc)
--     assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
--     assert(typeof(setupFunc) == "function", "The setup function is not a function!")
    
--     local SetupRet = setupFunc()
--     local StoreValue = {
--         storeId = storeId
--     }

--     local StateBase = {}
--     local StateLinked = {}
--     local ComputedLinked = {}

--     for key, value in SetupRet do
--         if typeof(value) == "function" then
--             -- action
--             StoreValue[key] = function(props: any | nil)
--                 return value(StoreValue, props)
--             end
--         elseif value.recompute ~= nil then
--             -- computed
--             StoreValue[key] = value
--             ComputedLinked[key] = StoreValue[key]
--         else
--             -- ref
--             StateBase[key] = value
--             StoreValue[key] = ref(value.value)
--             StateLinked[key] = StoreValue[key]
--         end
--     end

--     StoreValue._state = StateLinked
--     StoreValue._getters = ComputedLinked
--     StoreValue._reset = function()
--         for key, value in StateBase do
--             StoreValue[key] = ref(value.value)
--             StateLinked[key] = StoreValue[key]
--         end
--     end
--     StoreValue._patch = function(patchFunc: (state: {[string]: StateTypes.Ref<any>}) -> nil)
--         patchFunc(StateLinked)
--     end

--     return StoreValue
-- end

return {
    defineStore = defineStore
    -- defineStoreSetup = defineStoreSetup
}