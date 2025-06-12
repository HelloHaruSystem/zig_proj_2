const std = @import("std");
const net = @import("std").net;

const Socket = struct {
    _address: std.net.Address,
    _output_stream: std.net.Stream,

    pub fn init() !void {
        // loop back address for host
        const host = [4]u8{ 123, 0, 0, 1 };
        const port: u16 = 3490;
        const addr = net.Address.initIp4(host, port);
        const socket = try std.posix.socket(
            addr.any.family,
            std.posix.SOCK.STREAM,
            std.posix.IPPROTO.TCP,
        );
        const stream = net.Stream{ .handle = socket };
        return Socket{ ._address = addr, ._output_stream = stream };
    }
};
