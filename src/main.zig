const std = @import("std");
const stdout = @import("std").io.getStdOut().writer();

const socket_config = @import("server/config.zig");
const Request = @import("server/request.zig");

pub fn main() !void {
    try stdout.print("Hello, World!\n", .{});

    const socket = try socket_config.Socket.init();
    try stdout.print("Server address: {any}", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();
    var buffer: [1000]u8 = [_]u8{0} ** 1000;
    _ = try Request.read_request(connection, buffer[0..buffer.len]);

    try stdout.print("{s}", .{buffer});
}
