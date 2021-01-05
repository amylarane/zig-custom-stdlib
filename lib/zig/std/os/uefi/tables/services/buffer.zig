const uefi = @import("std").os.uefi;
const Status = uefi.Status;

pub const BufferServices = extern struct {    
    /// Computes and returns a 32-bit CRC for a data buffer.
    calculateCrc32: fn ([*]const u8, usize, *u32) callconv(.C) Status,

    /// Copies the contents of one buffer to another buffer
    copyMem: fn ([*]u8, [*]const u8, usize) callconv(.C) void,

    /// Fills a buffer with a specified value
    setMem: fn ([*]u8, usize, u8) callconv(.C) void,
};