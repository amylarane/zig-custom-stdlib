const uefi = @import("std").os.uefi;
const Status = uefi.Status;

pub const MemoryServices = extern struct {
    /// Allocates memory pages from the system
    allocatePages: fn (AllocateType, MemoryType, usize, *[*]align(4096) u8) callconv(.C) Status,
    
    /// Frees memory pages.
    freePages: fn ([*]align(4096) u8, usize) callconv(.C) Status,
    
    /// Returns the current memory map.
    getMemoryMap: fn (*usize, [*]MemoryDescriptor, *usize, *usize, *u32) callconv(.C) Status,
    
    /// Allocates pool memory.
    allocatePool: fn (usize, usize, *?*c_void) callconv(.C) Status,
    
    /// Returns pool memory to the system.
    freePool: fn ([*]align(8) u8) callconv(.C) Status,
};

pub const AllocateType = extern enum(usize) {
    AllocateAnyPages,
    AllocateMaxAddress,
    AllocateAddress,
};

pub const MemoryType = extern enum(usize) {
    ReservedMemoryType,
    LoaderCode,
    LoaderData,
    BootServicesCode,
    BootServicesData,
    RuntimeServicesCode,
    RuntimeServicesData,
    ConventionalMemory,
    UnusableMemory,
    ACPIReclaimMemory,
    ACPIMemoryNVS,
    MemoryMappedIO,
    MemoryMappedIOPortSpace,
    PalCode,
    PersistentMemory,
    MaxMemoryType,
};

pub const MemoryDescriptor = extern struct {
    type: MemoryType,
    physical_start: u64,
    virtual_start: u64,
    number_of_pages: usize,
    attribute: packed struct {
        uc: bool,
        wc: bool,
        wt: bool,
        wb: bool,
        uce: bool,
        _pad1: u7,
        wp: bool,
        rp: bool,
        xp: bool,
        nv: bool,
        more_reliable: bool,
        ro: bool,
        sp: bool,
        cpu_crypto: bool,
        _pad2: u43,
        memory_runtime: bool,
    },
};