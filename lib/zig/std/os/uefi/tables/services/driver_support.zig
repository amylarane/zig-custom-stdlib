const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Handle = uefi.Handle;
const Status = uefi.Status;

const DevicePathProtocol = uefi.protocols.DevicePathProtocol;


pub const DriverSupportServices = extern struct {
    /// Connect one or more drivers to a controller
    connectController: fn(Handle, ?*Handle, ?*DevicePathProtocol, bool) callconv(.C) Status,
    /// Disconnect one or more drivers from a controller
    disconnectController: fn(Handle, ?Handle, ?Handle) callconv(.C) Status,
};