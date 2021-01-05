const uefi = @import("std").os.uefi;
const Status = uefi.Status;

pub const DriverSupportServices = extern struct {
    connectController: Status, // TODO
    disconnectController: Status, // TODO
};