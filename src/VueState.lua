local ref = function (value)
    return {
        value = value
    }
end

local computed = function(computedFunc)
    return {
        value = computedFunc()
    }
end

return {
    ref = ref,
    computed = computed
}