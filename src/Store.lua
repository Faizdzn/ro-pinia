local PiniaTypes = require(script.Parent.types.Pinia)
local PiniaState = require(script.Parent.VueState)

local defineStore: PiniaTypes.defineStore = function(storeId, properties)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    
    local state = properties.state()
    if state ~= nil then
        local computed = PiniaState.computed
        local ref = PiniaState.ref

        local StoreValue = {
            storeId = storeId
        }
        for key, value in state do
            StoreValue[key] = ref(value)
        end

        for key, value in properties.getters do
            StoreValue[key] = computed(function()
                return value(state)
            end)
        end

        for key, value in properties.actions do
            StoreValue[key] = function(props: any | nil)
                return value(StoreValue, props)
            end
        end

        return StoreValue
    else
        return nil
    end
end

local defineStoreSetup: PiniaTypes.defineStoreSetup = function(storeId, setupFunc)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    assert(typeof(setupFunc) == "function", "The setup function is not a function!")
    
    local ValueTable = setupFunc()
    ValueTable["storeId"] = storeId

    return ValueTable
end

return {
    defineStore = defineStore,
    defineStoreSetup = defineStoreSetup
}