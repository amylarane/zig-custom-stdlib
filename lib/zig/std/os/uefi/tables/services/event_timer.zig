const uefi = @import("std").os.uefi;
const Status = uefi.Status;
const Event = uefi.Event;

pub const EventTimerServices = extern struct {
    /// Creates an event.
    createEvent: fn (u32, usize, ?fn (Event, ?*c_void) callconv(.C) void, ?*const c_void, *Event) callconv(.C) Status,

    /// Sets the type of timer and the trigger time for a timer event.
    setTimer: fn (Event, TimerDelay, u64) callconv(.C) Status,

    /// Stops execution until an event is signaled.
    waitForEvent: fn (usize, [*]const Event, *usize) callconv(.C) Status,

    /// Signals an event.
    signalEvent: fn (Event) callconv(.C) Status,

    /// Closes an event.
    closeEvent: fn (Event) callconv(.C) Status,

    /// Checks whether an event is in the signaled state.
    checkEvent: fn (Event) callconv(.C) Status,
    
    pub const event_timer: u32 = 0x80000000;
    pub const event_runtime: u32 = 0x40000000;
    pub const event_notify_wait: u32 = 0x00000100;
    pub const event_notify_signal: u32 = 0x00000200;
    pub const event_signal_exit_boot_services: u32 = 0x00000201;
    pub const event_signal_virtual_address_change: u32 = 0x00000202;
};

pub const TimerDelay = extern enum(u32) {
    TimerCancel,
    TimerPeriodic,
    TimerRelative,
};