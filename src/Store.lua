local PiniaState = require(script.Parent.VueState)

local defineStoreOpt = function(storeId, properties)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    
    local state = properties.state()
    if state ~= nil then
        local computed = PiniaState.computed
        local ref = PiniaState.ref

        local StoreValue = {
            storeId = storeId
        }
        local StateLinked = {}
        for key, value in state do
            StoreValue[key] = ref(value)
            StateLinked[key] = StoreValue[key]
        end

        for key, value in properties.getters do
            StoreValue[key] = computed(function()
                return value(StateLinked)
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

local defineStoreSetup = function(storeId, setupFunc)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    assert(typeof(setupFunc) == "function", "The setup function is not a function!")
    
    local ValueTable = setupFunc()
    ValueTable["storeId"] = storeId

    return ValueTable
end

return {
    defineStoreOpt = defineStoreOpt,
    defineStoreSetup = defineStoreSetup
}