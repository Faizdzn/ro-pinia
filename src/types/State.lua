export type Ref<T> = {
    value: T
}
export type ComputedRef = <T>(computedFunc: () -> T) -> Ref<T>

return nil