export type defineStoreSetup = (storeId: string, setupFunc: () -> {any}) -> {any}
export type defineStoreOpt = (storeId: string, properties: {
    state: () -> nil,
    getters: {
        [string]: (state: {any}) -> any
    },
    actions: {
        [string]: (self: {any}, properties: any | nil) -> any
    }
}) -> {any}
