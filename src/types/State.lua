export type Ref<T> = {
    value: T
}
export type ComputedRef = <T>(computedFunc: () -> T) -> {
    value: T,
    recompute: () -> nil
}
export type WatchRef = (watchRef: Ref<any>, watchFunc: (oldVal: Ref<any>, newVal: Ref<any>) -> nil) -> nil

return nil