const std = @import("std");
const io_helper = @import("tools.zig");
pub fn slove(allocator: std.mem.Allocator, input: []u8) []u8 {
    _ = allocator;
    _ = input;
}
pub fn main() !void {
    try io_helper.run(slove);
}
