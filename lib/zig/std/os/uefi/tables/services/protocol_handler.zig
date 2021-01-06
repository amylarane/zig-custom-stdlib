const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Status = uefi.Status;
const Handle = uefi.Handle;
const InterfaceType = uefi.InterfaceType;
const DevicePathProtocol = uefi.protocols.DevicePathProtocol;

const LocateSearchType = uefi.tables.LocateSearchType;

pub const ProtocolHandlerServices = extern struct {
    installProtocolInterface: fn (Handle, *align(8) const Guid, InterfaceType, *?*c_void) callconv(.C) Status,
    reinstallProtocolInterface: fn (Handle, *align(8) const Guid, *?*c_void, *?*c_void) callconv(.C) Status,
    uninstallProtocolInterface: fn (Handle, *align(8) const Guid, *?*c_void) callconv(.C) Status,

    /// Queries a handle to determine if it supports a specified protocol.
    handleProtocol: fn (Handle, *align(8) const Guid, *?*c_void) callconv(.C) Status,

    reserved: *c_void,

    registerProtocolNotify: fn (*align(8) const Guid, Event, *?*c_void) callconv(.C) Status,

    /// Returns an array of handles that support a specified protocol.
    locateHandle: fn (LocateSearchType, ?*align(8) const Guid, ?*const c_void, *usize, [*]Handle) callconv(.C) Status,

    locateDevicePath: fn (*align(8) const Guid, ?**DevicePathProtocol, ?*Handle) callconv(.C) Status, // TODO
};

