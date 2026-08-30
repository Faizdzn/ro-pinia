export type defineStoreSetup = (storeId: string, setupFunc: () -> table) -> table
export type defineStore = (storeId: string, properties: {
    state: () -> nil,
    getters: {
        [string]: (state: table) -> any
    },
    actions: {
        [string]: (self: table, properties: any | nil) -> any
    }
}) -> table

return nil