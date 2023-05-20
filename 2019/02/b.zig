const std = @import("std");
const os = std.os;
const mem = std.mem;
const print = std.debug.print;

const pa = std.heap.page_allocator;
pub fn main() !void {
    const fd = try os.open("input", 0, 0);

    var read_buf = try pa.alloc(u8, 2000);
    defer pa.free(read_buf);

    _ = try os.read(fd, read_buf);

    var read_iter = std.mem.tokenize(u8, read_buf, ",|\n");

    var nums = std.ArrayList(i32).init(pa);
    defer nums.deinit();

    while (read_iter.next()) |val| {
        const x = std.fmt.parseInt(i32, val, 10) catch continue;
        try nums.append(x);
    }

    try test_loop(&nums.items, pa);
}

pub fn test_loop(nums: *[]i32, alloc: mem.Allocator) !void {
    var i: i32 = 0;
    while (i < 100) : (i += 1) {
        var j: i32 = 0;
        while (j < 100) : (j += 1) {
            var nums_cpy = try copy_buffer(nums, alloc);
            defer alloc.free(nums_cpy);

            var ans = incode(&nums_cpy, i, j);
            if (ans == 19690720) {
                print("--{} {} {}\n", .{ i, j, ans });
                print("{}\n", .{100 * i + j});
                return;
            }
        }
    }
}

pub fn copy_buffer(nums: *[]i32, alloc: mem.Allocator) ![]i32 {
    var nums_cpy = try alloc.alloc(i32, nums.len);
    var i: usize = 0;

    while (i < nums.len) : (i += 1) {
        nums_cpy[i] = nums.*[i];
    }
    return nums_cpy;
}

pub fn incode(nums: *[]i32, noun: i32, verb: i32) i32 {
    nums.*[1] = noun;
    nums.*[2] = verb;

    var i: usize = 0;

    while (i < nums.*.len) : (i += 4) {
        var a = @intCast(usize, nums.*[i + 1]);
        var b = @intCast(usize, nums.*[i + 2]);
        var place = @intCast(usize, nums.*[i + 3]);

        switch (nums.*[i]) {
            1 => {
                nums.*[place] = nums.*[a] + nums.*[b];
            },
            2 => {
                nums.*[place] = nums.*[a] * nums.*[b];
            },
            99 => {
                break;
            },
            else => break,
        }
    }

    return nums.*[0];
}
