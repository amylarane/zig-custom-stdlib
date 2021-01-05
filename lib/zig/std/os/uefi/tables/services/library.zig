const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Handle = uefi.Handle;
const Status = uefi.Status;

const LocateSearchType = uefi.tables.LocateSearchType;


pub const LibraryServices = extern struct {
     /// Retrieves the list of protocol interface GUIDs that are installed on a handle in a buffer allocated from pool.
    protocolsPerHandle: fn (Handle, *[*]*align(8) const Guid, *usize) callconv(.C) Status,

    /// Returns an array of handles that support the requested protocol in a buffer allocated from pool.
    locateHandleBuffer: fn (LocateSearchType, ?*align(8) const Guid, ?*const c_void, *usize, *[*]Handle) callconv(.C) Status,

    /// Returns the first protocol instance that matches the given protocol.
    locateProtocol: fn (*align(8) const Guid, ?*const c_void, *?*c_void) callconv(.C) Status,

    installMultipleProtocolInterfaces: Status, // TODO
    uninstallMultipleProtocolInterfaces: Status, // TODO
};