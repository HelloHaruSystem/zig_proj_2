const Map = @import("std").static_string_map.StaticStringMap;

pub const Method = enum {
    get,

    pub fn init(text: []const u8) !Method {
        return MethodMap.get(text).?;
    }

    pub fn is_supported(m: []const u8) bool {
        const method = MethodMap.get(m);
        if (method) |_| {
            return true;
        }
        return false;
    }
};

const MethodMap = Map(Method).initComptime(.{
    .{ "GET", Method.get },
});
