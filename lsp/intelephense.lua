return {
    init_options = {
        globalStoragePath = (os.getenv("XDG_DATA_HOME") or "") .. "/intelephense",
        licenceKey = (os.getenv("XDG_CONFIG_HOME") or "") .. "/intelephense/licence.txt",
    },
}
