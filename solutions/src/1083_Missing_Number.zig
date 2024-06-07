const std = @import("std");
const io_helper = @import("tools.zig");
const Allocator = std.mem.Allocator;
const RunError = io_helper.RunFunctionError;
pub fn slove(allocator: Allocator, arg: []u8) RunError![]u8 {
    // std.debug.print("arg_input {s}\n", .{arg});
    var it = std.mem.split(u8, arg, "\n");
    const count = try std.fmt.parseInt(usize, it.next().?, 10);
    var numbers_it = std.mem.split(u8, it.next().?, " ");
    const slice = try allocator.alloc(bool, count);
    defer allocator.free(slice);

    while (numbers_it.next()) |number_str| {
        const number = try std.fmt.parseInt(usize, number_str, 10);
        slice[number - 1] = true;
    }
    for (slice, 0..) |status, num| {
        if (!status) {
            const res_num = try std.fmt.allocPrint(allocator, "{}\n", .{num + 1});
            return res_num;
        }
    }
    unreachable;
}
pub fn main() !void {
    try io_helper.run(slove);
}
