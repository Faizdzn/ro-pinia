export type Ref<T> = {
    value: T
}
export type ComputedRef = <T>(computedFunc: () -> T) -> {
    value: T,
    recompute: () -> nil
}

return nil