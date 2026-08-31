local StateTypes = require(script.Parent.State)

type defineStoreResult = {
    _state: {[string]: StateTypes.Ref<any>},
    _reset: () -> nil,
    _getters: {[string]: StateTypes.ComputedRef},
    _patch: (patchFunc: (state: StateTypes.Ref<any>) -> nil) -> nil,
    [string]: any
}
export type defineStoreSetup = (storeId: string, setupFunc: () -> {any}) -> defineStoreResult
export type defineStoreOpt = (storeId: string, properties: {
    state: () -> nil,
    getters: {
        [string]: (state: {any}) -> any
    },
    actions: {
        [string]: (self: {any}, properties: any | nil) -> any
    }
}) -> defineStoreResult

return nil