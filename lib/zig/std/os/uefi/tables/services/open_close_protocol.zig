const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Handle = uefi.Handle;
const Status = uefi.Status;

pub const OpenCloseProtocolServices = extern struct {
     /// Queries a handle to determine if it supports a specified protocol.
    openProtocol: fn (Handle, *align(8) const Guid, *?*c_void, ?Handle, ?Handle, OpenProtocolAttributes) callconv(.C) Status,

    /// Closes a protocol on a handle that was opened using openProtocol().
    closeProtocol: fn (Handle, *align(8) const Guid, Handle, ?Handle) callconv(.C) Status,

    /// Retrieves the list of agents that currently have a protocol interface opened.
    openProtocolInformation: fn (Handle, *align(8) const Guid, *[*]ProtocolInformationEntry, *usize) callconv(.C) Status,

};

pub const OpenProtocolAttributes = packed struct {
    by_handle_protocol: bool = false,
    get_protocol: bool = false,
    test_protocol: bool = false,
    by_child_controller: bool = false,
    by_driver: bool = false,
    exclusive: bool = false,
    _pad: u26 = undefined,
};

pub const ProtocolInformationEntry = extern struct {
    agent_handle: ?Handle,
    controller_handle: ?Handle,
    attributes: OpenProtocolAttributes,
    open_count: u32,
};