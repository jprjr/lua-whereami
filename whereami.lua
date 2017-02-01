local ok, ffi = pcall(require,'ffi')
if ok then
    ffi.cdef[[
int wai_getExecutablePath(char* out, int capacity, int* dirname_length);
]]
    local dir_sep, sep, sub
    local gmatch = string.gmatch
    local match = string.match
    local open = io.open
    local close = io.close

    for m in gmatch(package.config, '[^\n]+') do
        local m = m:gsub('([^%w])','%%%1')
        if not dir_sep then dir_sep = m
            elseif not sep then sep = m
            elseif not sub then sub = m end
    end

    local function find_lib(name)
      for m in gmatch(package.cpath, '[^' .. sep ..';]+') do
          local so_path, r = m:gsub(sub,name)
          if(r > 0) then
              local f = open(so_path)
              if f ~= nil then
                  close(f)
                  return so_path
              end
          end
      end
    end

    local function load_lib()
       local so_name = 'whereami' .. dir_sep .. 'core'
       local so_path = find_lib(so_name)
       if so_path then
           return ffi.load(so_path)
       end
    end

    local lib = load_lib()
    if lib then
        return function()
            local path_size = lib.wai_getExecutablePath(nil,0,nil)
            local path = ffi.new("char[?]",path_size)
            local res = lib.wai_getExecutablePath(path,path_size,nil)
            return ffi.string(path,path_size), nil
        end
    end

    return nil,'failed to load module'
else
    return require'whereami.core'
end
