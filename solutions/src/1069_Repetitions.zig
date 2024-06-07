const std = @import("std");
const io_helper = @import("tools.zig");
const RunError = io_helper.RunFunctionError;
const Allocator = std.mem.Allocator;
pub fn slove(allocator: Allocator, input: []u8) RunError![]u8 {
    // _ = allocator;
    // std.debug.print("arg_input {s}\n", .{arg});
    var prev_ch: u8 = ' ';
    var max_count: u32 = 1;
    var current_count: u32 = 0;
    for (input) |ch| {
        if (ch == prev_ch) {
            current_count += 1;
        } else {
            max_count = if (current_count > max_count) current_count else max_count;
            current_count = 1;
            prev_ch = ch;
        }
    }
    return try std.fmt.allocPrint(allocator, "{}\n", .{max_count});
}
pub fn main() !void {
    try io_helper.run(slove);
}
