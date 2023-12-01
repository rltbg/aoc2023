const std = @import("std");
const print = std.debug.print;
const inputFile = @embedFile("input");
const args = true; //or false for the 1st part

pub fn main() !void {
    var value: u32 = 0;
    var first: ?u32 = null;
    var last: u32 = undefined;

    const digit_strings = .{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

    loop: for (inputFile, 0..) |c, i| {
        switch (c) {
            '\n' => {
                value += first.? * 10 + last;
                first = null;
            },
            '0'...'9' => {
                if (first == null) first = c - '0';
                last = c - '0';
            },
            else => if (args) {inline for (digit_strings, 1..) |digit, abc| {
                if (std.mem.startsWith(u8, inputFile[i..], digit)) {
                    if (first == null) first = abc;
                    last = abc;
                    continue :loop;
                }
            }}
        }
    }
    if (first) |_| value += first.? * 10 + last;

    print("value: {d}\n", .{value});
}
