const std = @import("std");
const stdout = @import("std").io.getStdOut().writer();

const socket_config = @import("server/config.zig");
const Method = @import("server/http_method.zig").Method;
const Request = @import("server/request.zig");
const Response = @import("server/response.zig");

pub fn main() !void {
    try stdout.print("Hello, World!\n", .{});

    const socket = try socket_config.Socket.init();
    try stdout.print("Server Addr: {any}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();

    var buffer: [1000]u8 = [_]u8{0} ** 1000;
    try Request.read_request(connection, buffer[0..buffer.len]);
    const request = Request.parse_request(buffer[0..buffer.len]);
    if (request.method == Method.get) {
        if (std.mem.eql(u8, request.uri, "/")) {
            try Response.send_200(connection);
        } else {
            try Response.send_404(connection);
        }
    }

    try stdout.print("{any}\n", .{request});
}
