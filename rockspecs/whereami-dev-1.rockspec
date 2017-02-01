package = "whereami"
version = "dev-1"

source = {
    url = "gitrec+https://github.com/jprjr/lua-whereami.git"
}

description = {
    summary = "A multi-platform library for finding the executable name",
    homepage = "https://github.com/jprjr/lua-whereami",
    maintainer = "John Regan <john@jrjrtech.com>",
    license = "MIT"
}

dependencies = {
    "lua",
    "luarocks-fetch-gitrec",
}

build = {
    type = "builtin",
    modules = {
        ['whereami'] = 'whereami.lua',
        ['whereami.core'] = {
            sources = { "lua-whereami.c","whereami/src/whereami.c" },
            incdirs = { "whereami/src" }
        }
    }
}

