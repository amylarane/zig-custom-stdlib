const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Status = uefi.Status;
const Handle = uefi.Handle;
const DevicePathProtocol = uefi.protocols.DevicePathProtocol;


pub const ImageServices = extern struct {
    /// Loads an EFI image into memory.
    loadImage: fn (bool, Handle, ?*const DevicePathProtocol, ?[*]const u8, usize, *?Handle) callconv(.C) Status,

    /// Transfers control to a loaded image's entry point.
    startImage: fn (Handle, ?*usize, ?*[*]u16) callconv(.C) Status,

    /// Terminates a loaded EFI image and returns control to boot services.
    exit: fn (Handle, Status, usize, ?*const c_void) callconv(.C) Status,

    /// Unloads an image.
    unloadImage: fn (Handle) callconv(.C) Status,

    /// Terminates all boot services.
    exitBootServices: fn (Handle, usize) callconv(.C) Status,
};