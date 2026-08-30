local VueStateTypes = require(script.Parent.types.State)

local ref: <T>(value: T) -> VueStateTypes.Ref<T> = function (value)
    return {
        value = value
    }
end

local computed: VueStateTypes.ComputedRef = function(computedFunc)
    return {
        value = computedFunc()
    }
end

return {
    ref = ref,
    computed = computed
}