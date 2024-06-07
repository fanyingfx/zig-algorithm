const std = @import("std");
const Allocator = std.mem.Allocator;
pub fn run(comptime f: fn (allocator: Allocator, str: []u8) []u8) !void {
    // read command line parameters
    // https://ziggit.dev/t/read-command-line-arguments/220
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    const stdout = std.io.getStdOut().writer();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    for (args[1..], 0..) |arg, index| {
        std.debug.print("{} arg: {s}\n", .{ index, arg });
    }
    const filename = args[1];
    const file = try std.fs.cwd().openFile(
        filename,
        .{},
    );
    defer file.close();

    const stat = try file.stat();
    const input_file_buff = try file.readToEndAlloc(allocator, stat.size);
    defer allocator.free(input_file_buff);
    const res = f(allocator, input_file_buff);
    defer allocator.free(res);
    try stdout.print("{s}", .{res});
}
