const std = @import("std");
pub fn run(comptime f: fn (str: []u8) void) !void {
    // read command line parameters
    // https://ziggit.dev/t/read-command-line-arguments/220

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

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
    const buff = try file.readToEndAlloc(allocator, stat.size);
    defer allocator.free(buff);

    f(buff);
}
