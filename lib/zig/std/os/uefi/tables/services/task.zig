pub const TaskServices = extern struct {
    /// Raises a task's priority level and returns its previous level.
    raiseTpl: fn (usize) callconv(.C) usize,
    
    /// Restores a task's priority level to its previous value.
    restoreTpl: fn (usize) callconv(.C) void,
    
    pub const tpl_application: usize = 4;
    pub const tpl_callback: usize = 8;
    pub const tpl_notify: usize = 16;
    pub const tpl_high_level: usize = 31;
};