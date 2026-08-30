export type defineStoreSetup = <T>(storeId: string, setupFunc: <T>() -> T) -> T
export type defineStore = (storeId: string, properties: {
    state: () -> nil,
    getters: {
        [string]: any
    },
    actions: {
        [string]: () -> any
    }
}) -> any

return nil