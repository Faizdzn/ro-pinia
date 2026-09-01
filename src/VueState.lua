local VueStateTypes = require(script.Parent.types.State)

local Signal = require(script.Parent.Packages.Signal)

local ref: <T>(value: T) -> VueStateTypes.Ref<T> = function (value)
    local Table = {
        value = value,
        _changedSignal = Signal.new()
    }
    local metaTable = setmetatable({}, {
        __index = Table,
        __newindex = function(_, key, value)
            if key == "value" then
                if Table.value ~= value then
                    Table._changedSignal:Fire(Table.value, value)
                    Table[key] = value
                end
            end
        end
    })

    return metaTable
end

local computed: VueStateTypes.ComputedRef = function(computedFunc)
    local ReturnRef = {
        value = computedFunc()
    }
    function ReturnRef:recompute()
        ReturnRef.value = computedFunc()
    end

    local computeMetaTable = setmetatable({}, {
        __index = ReturnRef
    })

    return computeMetaTable
end

local watch: VueStateTypes.WatchRef = function(watchRef, watchFunc)
    if watchRef.value ~= nil and watchRef.recompute == nil then
        watchRef._changedSignal:Connect(watchFunc)
    end
end

return {
    ref = ref,
    computed = computed,
    watch = watch
}