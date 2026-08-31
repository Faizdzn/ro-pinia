export type Ref<T> = {
    value: T
}
export type ComputedRef = <T>(computedFunc: (self: {[string]: any} | nil) -> T) -> {
    value: T,
    recompute: () -> nil,
    _func: () -> T
}

return nil