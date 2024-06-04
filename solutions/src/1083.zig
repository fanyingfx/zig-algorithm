const std = @import("std");
const tools = @import("tools.zig");
pub fn find_number(arg: []u8) void {
    std.debug.print("arg_input {s}\n", .{arg});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    const stdout = std.io.getStdOut().writer();
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
        if (!status)
            stdout.print("{}\n", .{num + 1}) catch unreachable;
    }

}
pub fn main() !void {
    try tools.run(find_number);
}
