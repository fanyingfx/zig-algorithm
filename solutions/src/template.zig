const std = @import("std");
const io_helper = @import("tools.zig");
pub fn slove(allocator: *std.mem.Allocator, arg: []u8) []u8 {
    _ = allocator;
    _ = arg;
}
pub fn main() !void {
    try io_helper.run(slove);
}
