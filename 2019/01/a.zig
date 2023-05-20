const std = @import("std");
const open = std.os.open;
const read = std.os.read;
const print = std.debug.print;

const gpa = std.heap.GeneralPurposeAllocator(.{}){};
const pa = std.heap.page_allocator;

pub fn main() !void {
    const fd = try open("input", 0, 0);

    var buf: []u8 = try pa.alloc(u8, 5000);
    defer pa.free(buf);

    _ = try read(fd, buf);

    _ = std.mem.trim(u8, buf, "\n");

    var iter = std.mem.split(u8, buf, "\n");

    var total: i32 = 0;
    while (iter.next()) |line| {
        const x: i32 = std.fmt.parseInt(i32, line, 10) catch continue;
        const y = (@divFloor(x, 3)) - 2;
        // print("{}\n", .{y});
        total += y;
    }

    print("{}\n", .{total});
}
