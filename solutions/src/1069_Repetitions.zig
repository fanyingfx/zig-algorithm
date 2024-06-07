const std = @import("std");
const io_helper = @import("tools.zig");
const Allocator = std.mem.Allocator;
pub fn slove(allocator: Allocator, arg: []u8) []u8 {
    std.debug.print("arg_input {s}\n", .{arg});
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    // defer _ = gpa.deinit();
    var it = std.mem.split(u8, arg, "\n");
    const count = std.fmt.parseInt(usize, it.next().?, 10) catch unreachable;
    var numbers_it = std.mem.split(u8, it.next().?, " ");
    const slice = allocator.alloc(bool, count) catch unreachable;
    defer allocator.free(slice);

    while (numbers_it.next()) |number_str| {
        const number = std.fmt.parseInt(usize, number_str, 10) catch unreachable;
        slice[number - 1] = true;
    }
    for (slice, 0..) |status, num| {
        std.debug.print("{} {}",.{status,num});
        if (!status) {
            const res_num = std.fmt.allocPrint(allocator, "{}", .{num + 1}) catch unreachable;
            return res_num;
        }
        // stdout.print("{}\n", .{num + 1}) catch unreachable;
    }
    unreachable;
}
pub fn main() !void {
    try io_helper.run(slove);

}
