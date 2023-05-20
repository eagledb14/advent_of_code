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

    var nums = std.ArrayList(i32).init(pa);
    defer nums.deinit();

    while (iter.next()) |line| {
        const x: i32 = std.fmt.parseInt(i32, line, 10) catch continue;
        try nums.append(x);
    }

    var total: i32 = 0;

    // for (nums.pop()) |num| {
    while (nums.items.len > 0) {
        const num = nums.pop();
        const y = (@divFloor(num, 3)) - 2;
        if (y > 0) {
            total += y;
            try nums.append(y);
        }
    }

    print("{}\n", .{total});
}
