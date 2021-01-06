// SPDX-License-Identifier: MIT
// Copyright (c) 2015-2021 Zig Contributors
// This file is part of [zig](https://ziglang.org/), which is MIT licensed.
// The MIT license requires this copyright notice to be included in all copies
// and substantial portions of the software.
const uefi = @import("std").os.uefi;
const Event = uefi.Event;
const Guid = uefi.Guid;
const Handle = uefi.Handle;
const Status = uefi.Status;
const TableHeader = uefi.tables.TableHeader;
const LocateSearchType = uefi.tables.LocateSearchType;

//const InterfaceType = uefi.InterfaceType;


/// Boot services are services provided by the system's firmware until the operating system takes
/// over control over the hardware by calling exitBootServices.
///
/// Boot Services must not be used after exitBootServices has been called. The only exception is
/// getMemoryMap, which may be used after the first unsuccessful call to exitBootServices.
/// After successfully calling exitBootServices, system_table.console_in_handle, system_table.con_in,
/// system_table.console_out_handle, system_table.con_out, system_table.standard_error_handle,
/// system_table.std_err, and system_table.boot_services should be set to null. After setting these
/// attributes to null, system_table.hdr.crc32 must be recomputed.
///
/// As the boot_services table may grow with new UEFI versions, it is important to check hdr.header_size.

const TaskServices = @import("services/task.zig").TaskServices;
const MemoryServices = @import("services/memory.zig").MemoryServices;
const EventTimerServices = @import("services/event_timer.zig").EventTimerServices;
const ProtocolHandlerServices = @import("services/protocol_handler.zig").ProtocolHandlerServices;
const ImageServices = @import("services/image.zig").ImageServices;
const BufferServices = @import("services/buffer.zig").BufferServices;
const DriverSupportServices = @import("services/driver_support.zig").DriverSupportServices;
const OpenCloseProtocolServices = @import("services/open_close_protocol.zig").OpenCloseProtocolServices;
const LibraryServices = @import("services/library.zig").LibraryServices;

pub const BootServices = extern struct {
    hdr: TableHeader, 
    
    task: TaskServices,
    memory: MemoryServices,
    event_timer: EventTimerServices,
    protocol_handler: ProtocolHandlerServices, 
    installConfigurationTable: fn(*align(8) const Guid, *?*c_void) callconv(.C) Status,    
    image: ImageServices,
    
    getNextMonotonicCount: fn (*u64) callconv(.C) Status,
    stall: fn (usize) callconv(.C) Status,
    setWatchdogTimer: fn (usize, u64, usize, ?[*]const u16) callconv(.C) Status,
    
    driver_support: DriverSupportServices,
    open_close_protocol: OpenCloseProtocolServices,
    library: LibraryServices,      
    buffer: BufferServices,   

    createEventEx: Status, // TODO

    pub const signature: u64 = 0x56524553544f4f42;
};








