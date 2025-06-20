const std = @import("std");
const Connection = @import("std").net.Server.Connection;

const Method = @import("http_method.zig").Method;

pub fn read_request(connection: Connection, buffer: []u8) !void {
    const reader = connection.stream.reader();
    _ = try reader.read(buffer);
}

const Request = struct {
    method: Method,
    version: []const u8,
    uri: []const u8,

    pub fn init(method: Method, uri: []const u8, version: []const u8) Request {
        return Request{
            .method = method,
            .uri = uri,
            .version = version,
        };
    }
};

pub fn parse_request(text: []const u8) Request {
    const line_index = std.mem.indexOfScalar(u8, text, '\n') orelse text.len;
    var iterator = std.mem.splitScalar(u8, text[0..line_index], ' ');
    const method = try Method.init(iterator.next().?);
    const uri = iterator.next().?;
    const version = iterator.next().?;
    const request = Request.init(method, uri, version);

    return request;
}
