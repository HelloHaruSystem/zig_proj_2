const std = @import("std");
const stdout = @import("std").io.getStdOut().writer();

const socket_config = @import("server/config.zig");

pub fn main() !void {
    try stdout.print("Hello, World!\n", .{});

    const socket = try socket_config.Socket.init();
    try stdout.print("Server address: {any}", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();
    _ = connection;
}
