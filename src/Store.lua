local PiniaTypes = require(script.Parent.types.Pinia)

local defineStore: PiniaTypes.defineStore = function(storeId, properties)
    -- assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    -- assert(typeof(setupFunc) == "function", "The setup function is not a function!")
    
    -- local ValueTable = setupFunc()
    -- return ValueTable
end

local defineStoreSetup: PiniaTypes.defineStoreSetup = function(storeId, setupFunc)
    assert(typeof(storeId) == "string", "The storeId types you initiate are not a string!")
    assert(typeof(setupFunc) == "function", "The setup function is not a function!")
    
    local ValueTable = setupFunc()
    return ValueTable
end

return {
    defineStore = defineStore,
    defineStoreSetup = defineStoreSetup
}