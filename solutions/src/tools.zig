const std = @import("std");
pub fn my_func(arg: []const u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("{s} 100", .{arg}) catch unreachable;
}
pub fn run(comptime f: fn (str: []u8) void) !void {

    // const stdout = std.io.getStdOut().writer();
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();
    // Parse args into string array (error union needs 'try')
    // const args = try std.process.argsAlloc(allocator);
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    // try stdout.print("There are {d} args:\n", .{args.len-1});
    for (args[1..], 0..) |arg, index| {
        std.debug.print("{} arg: {s}\n", .{ index, arg });
    }
    const filename=args[1];
    const file = try std.fs.cwd().openFile(
        filename,
        .{},
    );
    defer file.close();

    const stat = try file.stat();
    const buff = try file.readToEndAlloc(allocator, stat.size);
    defer allocator.free(buff);
    
    // std.debug.print("current args: {}",args);
    f(buff);

    // try stdout.print("{s} 100", .{args[1]});
}
pub fn main() !void {
    try run(my_func);
}
