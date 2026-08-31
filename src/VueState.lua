local VueStateTypes = require(script.Parent.types.State)

local ref: <T>(value: T) -> VueStateTypes.Ref<T> = function (value)
    return {
        value = value
    }
end

local computed: VueStateTypes.ComputedRef = function(computedFunc)
    local ReturnRef = {
        value = computedFunc(),
        _func = computedFunc
    }
    function ReturnRef:recompute() 
        print(computedFunc())
        ReturnRef.value = computedFunc()
    end

    return ReturnRef
end

return {
    ref = ref,
    computed = computed
}