// SPDX-License-Identifier: MIT
// Copyright (c) 2015-2021 Zig Contributors
// This file is part of [zig](https://ziglang.org/), which is MIT licensed.
// The MIT license requires this copyright notice to be included in all copies
// and substantial portions of the software.
const std = @import("../std.zig");
const CpuFeature = std.Target.Cpu.Feature;
const CpuModel = std.Target.Cpu.Model;

pub const Feature = enum {
    addsubiw,
    avr0,
    avr1,
    avr2,
    avr25,
    avr3,
    avr31,
    avr35,
    avr4,
    avr5,
    avr51,
    avr6,
    avrtiny,
    @"break",
    des,
    eijmpcall,
    elpm,
    elpmx,
    ijmpcall,
    jmpcall,
    lpm,
    lpmx,
    memmappedregs,
    movw,
    mul,
    rmw,
    smallstack,
    special,
    spm,
    spmx,
    sram,
    tinyencoding,
    xmega,
    xmegau,
};

pub usingnamespace CpuFeature.feature_set_fns(Feature);

pub const all_features = blk: {
    const len = @typeInfo(Feature).Enum.fields.len;
    std.debug.assert(len <= CpuFeature.Set.needed_bit_count);
    var result: [len]CpuFeature = undefined;
    result[@enumToInt(Feature.addsubiw)] = .{
        .llvm_name = "addsubiw",
        .description = "Enable 16-bit register-immediate addition and subtraction instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.avr0)] = .{
        .llvm_name = "avr0",
        .description = "The device is a part of the avr0 family",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.avr1)] = .{
        .llvm_name = "avr1",
        .description = "The device is a part of the avr1 family",
        .dependencies = featureSet(&[_]Feature{
            .avr0,
            .lpm,
            .memmappedregs,
        }),
    };
    result[@enumToInt(Feature.avr2)] = .{
        .llvm_name = "avr2",
        .description = "The device is a part of the avr2 family",
        .dependencies = featureSet(&[_]Feature{
            .addsubiw,
            .avr1,
            .ijmpcall,
            .sram,
        }),
    };
    result[@enumToInt(Feature.avr25)] = .{
        .llvm_name = "avr25",
        .description = "The device is a part of the avr25 family",
        .dependencies = featureSet(&[_]Feature{
            .avr2,
            .@"break",
            .lpmx,
            .movw,
            .spm,
        }),
    };
    result[@enumToInt(Feature.avr3)] = .{
        .llvm_name = "avr3",
        .description = "The device is a part of the avr3 family",
        .dependencies = featureSet(&[_]Feature{
            .avr2,
            .jmpcall,
        }),
    };
    result[@enumToInt(Feature.avr31)] = .{
        .llvm_name = "avr31",
        .description = "The device is a part of the avr31 family",
        .dependencies = featureSet(&[_]Feature{
            .avr3,
            .elpm,
        }),
    };
    result[@enumToInt(Feature.avr35)] = .{
        .llvm_name = "avr35",
        .description = "The device is a part of the avr35 family",
        .dependencies = featureSet(&[_]Feature{
            .avr3,
            .@"break",
            .lpmx,
            .movw,
            .spm,
        }),
    };
    result[@enumToInt(Feature.avr4)] = .{
        .llvm_name = "avr4",
        .description = "The device is a part of the avr4 family",
        .dependencies = featureSet(&[_]Feature{
            .avr2,
            .@"break",
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    result[@enumToInt(Feature.avr5)] = .{
        .llvm_name = "avr5",
        .description = "The device is a part of the avr5 family",
        .dependencies = featureSet(&[_]Feature{
            .avr3,
            .@"break",
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    result[@enumToInt(Feature.avr51)] = .{
        .llvm_name = "avr51",
        .description = "The device is a part of the avr51 family",
        .dependencies = featureSet(&[_]Feature{
            .avr5,
            .elpm,
            .elpmx,
        }),
    };
    result[@enumToInt(Feature.avr6)] = .{
        .llvm_name = "avr6",
        .description = "The device is a part of the avr6 family",
        .dependencies = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    result[@enumToInt(Feature.avrtiny)] = .{
        .llvm_name = "avrtiny",
        .description = "The device is a part of the avrtiny family",
        .dependencies = featureSet(&[_]Feature{
            .avr0,
            .@"break",
            .memmappedregs,
            .sram,
            .tinyencoding,
        }),
    };
    result[@enumToInt(Feature.@"break")] = .{
        .llvm_name = "break",
        .description = "The device supports the `BREAK` debugging instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.des)] = .{
        .llvm_name = "des",
        .description = "The device supports the `DES k` encryption instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.eijmpcall)] = .{
        .llvm_name = "eijmpcall",
        .description = "The device supports the `EIJMP`/`EICALL` instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.elpm)] = .{
        .llvm_name = "elpm",
        .description = "The device supports the ELPM instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.elpmx)] = .{
        .llvm_name = "elpmx",
        .description = "The device supports the `ELPM Rd, Z[+]` instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ijmpcall)] = .{
        .llvm_name = "ijmpcall",
        .description = "The device supports `IJMP`/`ICALL`instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.jmpcall)] = .{
        .llvm_name = "jmpcall",
        .description = "The device supports the `JMP` and `CALL` instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lpm)] = .{
        .llvm_name = "lpm",
        .description = "The device supports the `LPM` instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lpmx)] = .{
        .llvm_name = "lpmx",
        .description = "The device supports the `LPM Rd, Z[+]` instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.memmappedregs)] = .{
        .llvm_name = "memmappedregs",
        .description = "The device has CPU registers mapped in data address space",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.movw)] = .{
        .llvm_name = "movw",
        .description = "The device supports the 16-bit MOVW instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.mul)] = .{
        .llvm_name = "mul",
        .description = "The device supports the multiplication instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.rmw)] = .{
        .llvm_name = "rmw",
        .description = "The device supports the read-write-modify instructions: XCH, LAS, LAC, LAT",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.smallstack)] = .{
        .llvm_name = "smallstack",
        .description = "The device has an 8-bit stack pointer",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.special)] = .{
        .llvm_name = "special",
        .description = "Enable use of the entire instruction set - used for debugging",
        .dependencies = featureSet(&[_]Feature{
            .addsubiw,
            .@"break",
            .des,
            .eijmpcall,
            .elpm,
            .elpmx,
            .ijmpcall,
            .jmpcall,
            .lpm,
            .lpmx,
            .memmappedregs,
            .movw,
            .mul,
            .rmw,
            .spm,
            .spmx,
            .sram,
        }),
    };
    result[@enumToInt(Feature.spm)] = .{
        .llvm_name = "spm",
        .description = "The device supports the `SPM` instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.spmx)] = .{
        .llvm_name = "spmx",
        .description = "The device supports the `SPM Z+` instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sram)] = .{
        .llvm_name = "sram",
        .description = "The device has random access memory",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.tinyencoding)] = .{
        .llvm_name = "tinyencoding",
        .description = "The device has Tiny core specific instruction encodings",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.xmega)] = .{
        .llvm_name = "xmega",
        .description = "The device is a part of the xmega family",
        .dependencies = featureSet(&[_]Feature{
            .addsubiw,
            .avr0,
            .@"break",
            .des,
            .eijmpcall,
            .elpm,
            .elpmx,
            .ijmpcall,
            .jmpcall,
            .lpm,
            .lpmx,
            .movw,
            .mul,
            .spm,
            .spmx,
            .sram,
        }),
    };
    result[@enumToInt(Feature.xmegau)] = .{
        .llvm_name = "xmegau",
        .description = "The device is a part of the xmegau family",
        .dependencies = featureSet(&[_]Feature{
            .rmw,
            .xmega,
        }),
    };
    const ti = @typeInfo(Feature);
    for (result) |*elem, i| {
        elem.index = i;
        elem.name = ti.Enum.fields[i].name;
    }
    break :blk result;
};

pub const cpu = struct {
    pub const at43usb320 = CpuModel{
        .name = "at43usb320",
        .llvm_name = "at43usb320",
        .features = featureSet(&[_]Feature{
            .avr31,
        }),
    };
    pub const at43usb355 = CpuModel{
        .name = "at43usb355",
        .llvm_name = "at43usb355",
        .features = featureSet(&[_]Feature{
            .avr3,
        }),
    };
    pub const at76c711 = CpuModel{
        .name = "at76c711",
        .llvm_name = "at76c711",
        .features = featureSet(&[_]Feature{
            .avr3,
        }),
    };
    pub const at86rf401 = CpuModel{
        .name = "at86rf401",
        .llvm_name = "at86rf401",
        .features = featureSet(&[_]Feature{
            .avr2,
            .lpmx,
            .movw,
        }),
    };
    pub const at90c8534 = CpuModel{
        .name = "at90c8534",
        .llvm_name = "at90c8534",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90can128 = CpuModel{
        .name = "at90can128",
        .llvm_name = "at90can128",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const at90can32 = CpuModel{
        .name = "at90can32",
        .llvm_name = "at90can32",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90can64 = CpuModel{
        .name = "at90can64",
        .llvm_name = "at90can64",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90pwm1 = CpuModel{
        .name = "at90pwm1",
        .llvm_name = "at90pwm1",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90pwm161 = CpuModel{
        .name = "at90pwm161",
        .llvm_name = "at90pwm161",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90pwm2 = CpuModel{
        .name = "at90pwm2",
        .llvm_name = "at90pwm2",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90pwm216 = CpuModel{
        .name = "at90pwm216",
        .llvm_name = "at90pwm216",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90pwm2b = CpuModel{
        .name = "at90pwm2b",
        .llvm_name = "at90pwm2b",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90pwm3 = CpuModel{
        .name = "at90pwm3",
        .llvm_name = "at90pwm3",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90pwm316 = CpuModel{
        .name = "at90pwm316",
        .llvm_name = "at90pwm316",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90pwm3b = CpuModel{
        .name = "at90pwm3b",
        .llvm_name = "at90pwm3b",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90pwm81 = CpuModel{
        .name = "at90pwm81",
        .llvm_name = "at90pwm81",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const at90s1200 = CpuModel{
        .name = "at90s1200",
        .llvm_name = "at90s1200",
        .features = featureSet(&[_]Feature{
            .avr0,
        }),
    };
    pub const at90s2313 = CpuModel{
        .name = "at90s2313",
        .llvm_name = "at90s2313",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s2323 = CpuModel{
        .name = "at90s2323",
        .llvm_name = "at90s2323",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s2333 = CpuModel{
        .name = "at90s2333",
        .llvm_name = "at90s2333",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s2343 = CpuModel{
        .name = "at90s2343",
        .llvm_name = "at90s2343",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s4414 = CpuModel{
        .name = "at90s4414",
        .llvm_name = "at90s4414",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s4433 = CpuModel{
        .name = "at90s4433",
        .llvm_name = "at90s4433",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s4434 = CpuModel{
        .name = "at90s4434",
        .llvm_name = "at90s4434",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s8515 = CpuModel{
        .name = "at90s8515",
        .llvm_name = "at90s8515",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90s8535 = CpuModel{
        .name = "at90s8535",
        .llvm_name = "at90s8535",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const at90scr100 = CpuModel{
        .name = "at90scr100",
        .llvm_name = "at90scr100",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90usb1286 = CpuModel{
        .name = "at90usb1286",
        .llvm_name = "at90usb1286",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const at90usb1287 = CpuModel{
        .name = "at90usb1287",
        .llvm_name = "at90usb1287",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const at90usb162 = CpuModel{
        .name = "at90usb162",
        .llvm_name = "at90usb162",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const at90usb646 = CpuModel{
        .name = "at90usb646",
        .llvm_name = "at90usb646",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90usb647 = CpuModel{
        .name = "at90usb647",
        .llvm_name = "at90usb647",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const at90usb82 = CpuModel{
        .name = "at90usb82",
        .llvm_name = "at90usb82",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const at94k = CpuModel{
        .name = "at94k",
        .llvm_name = "at94k",
        .features = featureSet(&[_]Feature{
            .avr3,
            .lpmx,
            .movw,
            .mul,
        }),
    };
    pub const ata5272 = CpuModel{
        .name = "ata5272",
        .llvm_name = "ata5272",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const ata5505 = CpuModel{
        .name = "ata5505",
        .llvm_name = "ata5505",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const ata5790 = CpuModel{
        .name = "ata5790",
        .llvm_name = "ata5790",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const ata5795 = CpuModel{
        .name = "ata5795",
        .llvm_name = "ata5795",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const ata6285 = CpuModel{
        .name = "ata6285",
        .llvm_name = "ata6285",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const ata6286 = CpuModel{
        .name = "ata6286",
        .llvm_name = "ata6286",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const ata6289 = CpuModel{
        .name = "ata6289",
        .llvm_name = "ata6289",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega103 = CpuModel{
        .name = "atmega103",
        .llvm_name = "atmega103",
        .features = featureSet(&[_]Feature{
            .avr31,
        }),
    };
    pub const atmega128 = CpuModel{
        .name = "atmega128",
        .llvm_name = "atmega128",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega1280 = CpuModel{
        .name = "atmega1280",
        .llvm_name = "atmega1280",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega1281 = CpuModel{
        .name = "atmega1281",
        .llvm_name = "atmega1281",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega1284 = CpuModel{
        .name = "atmega1284",
        .llvm_name = "atmega1284",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega1284p = CpuModel{
        .name = "atmega1284p",
        .llvm_name = "atmega1284p",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega1284rfr2 = CpuModel{
        .name = "atmega1284rfr2",
        .llvm_name = "atmega1284rfr2",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega128a = CpuModel{
        .name = "atmega128a",
        .llvm_name = "atmega128a",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega128rfa1 = CpuModel{
        .name = "atmega128rfa1",
        .llvm_name = "atmega128rfa1",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega128rfr2 = CpuModel{
        .name = "atmega128rfr2",
        .llvm_name = "atmega128rfr2",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const atmega16 = CpuModel{
        .name = "atmega16",
        .llvm_name = "atmega16",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega161 = CpuModel{
        .name = "atmega161",
        .llvm_name = "atmega161",
        .features = featureSet(&[_]Feature{
            .avr3,
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    pub const atmega162 = CpuModel{
        .name = "atmega162",
        .llvm_name = "atmega162",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega163 = CpuModel{
        .name = "atmega163",
        .llvm_name = "atmega163",
        .features = featureSet(&[_]Feature{
            .avr3,
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    pub const atmega164a = CpuModel{
        .name = "atmega164a",
        .llvm_name = "atmega164a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega164p = CpuModel{
        .name = "atmega164p",
        .llvm_name = "atmega164p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega164pa = CpuModel{
        .name = "atmega164pa",
        .llvm_name = "atmega164pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega165 = CpuModel{
        .name = "atmega165",
        .llvm_name = "atmega165",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega165a = CpuModel{
        .name = "atmega165a",
        .llvm_name = "atmega165a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega165p = CpuModel{
        .name = "atmega165p",
        .llvm_name = "atmega165p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega165pa = CpuModel{
        .name = "atmega165pa",
        .llvm_name = "atmega165pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega168 = CpuModel{
        .name = "atmega168",
        .llvm_name = "atmega168",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega168a = CpuModel{
        .name = "atmega168a",
        .llvm_name = "atmega168a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega168p = CpuModel{
        .name = "atmega168p",
        .llvm_name = "atmega168p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega168pa = CpuModel{
        .name = "atmega168pa",
        .llvm_name = "atmega168pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega169 = CpuModel{
        .name = "atmega169",
        .llvm_name = "atmega169",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega169a = CpuModel{
        .name = "atmega169a",
        .llvm_name = "atmega169a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega169p = CpuModel{
        .name = "atmega169p",
        .llvm_name = "atmega169p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega169pa = CpuModel{
        .name = "atmega169pa",
        .llvm_name = "atmega169pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16a = CpuModel{
        .name = "atmega16a",
        .llvm_name = "atmega16a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16hva = CpuModel{
        .name = "atmega16hva",
        .llvm_name = "atmega16hva",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16hva2 = CpuModel{
        .name = "atmega16hva2",
        .llvm_name = "atmega16hva2",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16hvb = CpuModel{
        .name = "atmega16hvb",
        .llvm_name = "atmega16hvb",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16hvbrevb = CpuModel{
        .name = "atmega16hvbrevb",
        .llvm_name = "atmega16hvbrevb",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16m1 = CpuModel{
        .name = "atmega16m1",
        .llvm_name = "atmega16m1",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega16u2 = CpuModel{
        .name = "atmega16u2",
        .llvm_name = "atmega16u2",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const atmega16u4 = CpuModel{
        .name = "atmega16u4",
        .llvm_name = "atmega16u4",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega2560 = CpuModel{
        .name = "atmega2560",
        .llvm_name = "atmega2560",
        .features = featureSet(&[_]Feature{
            .avr6,
        }),
    };
    pub const atmega2561 = CpuModel{
        .name = "atmega2561",
        .llvm_name = "atmega2561",
        .features = featureSet(&[_]Feature{
            .avr6,
        }),
    };
    pub const atmega2564rfr2 = CpuModel{
        .name = "atmega2564rfr2",
        .llvm_name = "atmega2564rfr2",
        .features = featureSet(&[_]Feature{
            .avr6,
        }),
    };
    pub const atmega256rfr2 = CpuModel{
        .name = "atmega256rfr2",
        .llvm_name = "atmega256rfr2",
        .features = featureSet(&[_]Feature{
            .avr6,
        }),
    };
    pub const atmega32 = CpuModel{
        .name = "atmega32",
        .llvm_name = "atmega32",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega323 = CpuModel{
        .name = "atmega323",
        .llvm_name = "atmega323",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega324a = CpuModel{
        .name = "atmega324a",
        .llvm_name = "atmega324a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega324p = CpuModel{
        .name = "atmega324p",
        .llvm_name = "atmega324p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega324pa = CpuModel{
        .name = "atmega324pa",
        .llvm_name = "atmega324pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega325 = CpuModel{
        .name = "atmega325",
        .llvm_name = "atmega325",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3250 = CpuModel{
        .name = "atmega3250",
        .llvm_name = "atmega3250",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3250a = CpuModel{
        .name = "atmega3250a",
        .llvm_name = "atmega3250a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3250p = CpuModel{
        .name = "atmega3250p",
        .llvm_name = "atmega3250p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3250pa = CpuModel{
        .name = "atmega3250pa",
        .llvm_name = "atmega3250pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega325a = CpuModel{
        .name = "atmega325a",
        .llvm_name = "atmega325a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega325p = CpuModel{
        .name = "atmega325p",
        .llvm_name = "atmega325p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega325pa = CpuModel{
        .name = "atmega325pa",
        .llvm_name = "atmega325pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega328 = CpuModel{
        .name = "atmega328",
        .llvm_name = "atmega328",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega328p = CpuModel{
        .name = "atmega328p",
        .llvm_name = "atmega328p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega329 = CpuModel{
        .name = "atmega329",
        .llvm_name = "atmega329",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3290 = CpuModel{
        .name = "atmega3290",
        .llvm_name = "atmega3290",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3290a = CpuModel{
        .name = "atmega3290a",
        .llvm_name = "atmega3290a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3290p = CpuModel{
        .name = "atmega3290p",
        .llvm_name = "atmega3290p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega3290pa = CpuModel{
        .name = "atmega3290pa",
        .llvm_name = "atmega3290pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega329a = CpuModel{
        .name = "atmega329a",
        .llvm_name = "atmega329a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega329p = CpuModel{
        .name = "atmega329p",
        .llvm_name = "atmega329p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega329pa = CpuModel{
        .name = "atmega329pa",
        .llvm_name = "atmega329pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32a = CpuModel{
        .name = "atmega32a",
        .llvm_name = "atmega32a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32c1 = CpuModel{
        .name = "atmega32c1",
        .llvm_name = "atmega32c1",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32hvb = CpuModel{
        .name = "atmega32hvb",
        .llvm_name = "atmega32hvb",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32hvbrevb = CpuModel{
        .name = "atmega32hvbrevb",
        .llvm_name = "atmega32hvbrevb",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32m1 = CpuModel{
        .name = "atmega32m1",
        .llvm_name = "atmega32m1",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32u2 = CpuModel{
        .name = "atmega32u2",
        .llvm_name = "atmega32u2",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const atmega32u4 = CpuModel{
        .name = "atmega32u4",
        .llvm_name = "atmega32u4",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega32u6 = CpuModel{
        .name = "atmega32u6",
        .llvm_name = "atmega32u6",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega406 = CpuModel{
        .name = "atmega406",
        .llvm_name = "atmega406",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega48 = CpuModel{
        .name = "atmega48",
        .llvm_name = "atmega48",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega48a = CpuModel{
        .name = "atmega48a",
        .llvm_name = "atmega48a",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega48p = CpuModel{
        .name = "atmega48p",
        .llvm_name = "atmega48p",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega48pa = CpuModel{
        .name = "atmega48pa",
        .llvm_name = "atmega48pa",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega64 = CpuModel{
        .name = "atmega64",
        .llvm_name = "atmega64",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega640 = CpuModel{
        .name = "atmega640",
        .llvm_name = "atmega640",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega644 = CpuModel{
        .name = "atmega644",
        .llvm_name = "atmega644",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega644a = CpuModel{
        .name = "atmega644a",
        .llvm_name = "atmega644a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega644p = CpuModel{
        .name = "atmega644p",
        .llvm_name = "atmega644p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega644pa = CpuModel{
        .name = "atmega644pa",
        .llvm_name = "atmega644pa",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega644rfr2 = CpuModel{
        .name = "atmega644rfr2",
        .llvm_name = "atmega644rfr2",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega645 = CpuModel{
        .name = "atmega645",
        .llvm_name = "atmega645",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6450 = CpuModel{
        .name = "atmega6450",
        .llvm_name = "atmega6450",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6450a = CpuModel{
        .name = "atmega6450a",
        .llvm_name = "atmega6450a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6450p = CpuModel{
        .name = "atmega6450p",
        .llvm_name = "atmega6450p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega645a = CpuModel{
        .name = "atmega645a",
        .llvm_name = "atmega645a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega645p = CpuModel{
        .name = "atmega645p",
        .llvm_name = "atmega645p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega649 = CpuModel{
        .name = "atmega649",
        .llvm_name = "atmega649",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6490 = CpuModel{
        .name = "atmega6490",
        .llvm_name = "atmega6490",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6490a = CpuModel{
        .name = "atmega6490a",
        .llvm_name = "atmega6490a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega6490p = CpuModel{
        .name = "atmega6490p",
        .llvm_name = "atmega6490p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega649a = CpuModel{
        .name = "atmega649a",
        .llvm_name = "atmega649a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega649p = CpuModel{
        .name = "atmega649p",
        .llvm_name = "atmega649p",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega64a = CpuModel{
        .name = "atmega64a",
        .llvm_name = "atmega64a",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega64c1 = CpuModel{
        .name = "atmega64c1",
        .llvm_name = "atmega64c1",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega64hve = CpuModel{
        .name = "atmega64hve",
        .llvm_name = "atmega64hve",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega64m1 = CpuModel{
        .name = "atmega64m1",
        .llvm_name = "atmega64m1",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega64rfr2 = CpuModel{
        .name = "atmega64rfr2",
        .llvm_name = "atmega64rfr2",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const atmega8 = CpuModel{
        .name = "atmega8",
        .llvm_name = "atmega8",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega8515 = CpuModel{
        .name = "atmega8515",
        .llvm_name = "atmega8515",
        .features = featureSet(&[_]Feature{
            .avr2,
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    pub const atmega8535 = CpuModel{
        .name = "atmega8535",
        .llvm_name = "atmega8535",
        .features = featureSet(&[_]Feature{
            .avr2,
            .lpmx,
            .movw,
            .mul,
            .spm,
        }),
    };
    pub const atmega88 = CpuModel{
        .name = "atmega88",
        .llvm_name = "atmega88",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega88a = CpuModel{
        .name = "atmega88a",
        .llvm_name = "atmega88a",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega88p = CpuModel{
        .name = "atmega88p",
        .llvm_name = "atmega88p",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega88pa = CpuModel{
        .name = "atmega88pa",
        .llvm_name = "atmega88pa",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega8a = CpuModel{
        .name = "atmega8a",
        .llvm_name = "atmega8a",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega8hva = CpuModel{
        .name = "atmega8hva",
        .llvm_name = "atmega8hva",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const atmega8u2 = CpuModel{
        .name = "atmega8u2",
        .llvm_name = "atmega8u2",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const attiny10 = CpuModel{
        .name = "attiny10",
        .llvm_name = "attiny10",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny102 = CpuModel{
        .name = "attiny102",
        .llvm_name = "attiny102",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny104 = CpuModel{
        .name = "attiny104",
        .llvm_name = "attiny104",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny11 = CpuModel{
        .name = "attiny11",
        .llvm_name = "attiny11",
        .features = featureSet(&[_]Feature{
            .avr1,
        }),
    };
    pub const attiny12 = CpuModel{
        .name = "attiny12",
        .llvm_name = "attiny12",
        .features = featureSet(&[_]Feature{
            .avr1,
        }),
    };
    pub const attiny13 = CpuModel{
        .name = "attiny13",
        .llvm_name = "attiny13",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny13a = CpuModel{
        .name = "attiny13a",
        .llvm_name = "attiny13a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny15 = CpuModel{
        .name = "attiny15",
        .llvm_name = "attiny15",
        .features = featureSet(&[_]Feature{
            .avr1,
        }),
    };
    pub const attiny1634 = CpuModel{
        .name = "attiny1634",
        .llvm_name = "attiny1634",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const attiny167 = CpuModel{
        .name = "attiny167",
        .llvm_name = "attiny167",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const attiny20 = CpuModel{
        .name = "attiny20",
        .llvm_name = "attiny20",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny22 = CpuModel{
        .name = "attiny22",
        .llvm_name = "attiny22",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const attiny2313 = CpuModel{
        .name = "attiny2313",
        .llvm_name = "attiny2313",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny2313a = CpuModel{
        .name = "attiny2313a",
        .llvm_name = "attiny2313a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny24 = CpuModel{
        .name = "attiny24",
        .llvm_name = "attiny24",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny24a = CpuModel{
        .name = "attiny24a",
        .llvm_name = "attiny24a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny25 = CpuModel{
        .name = "attiny25",
        .llvm_name = "attiny25",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny26 = CpuModel{
        .name = "attiny26",
        .llvm_name = "attiny26",
        .features = featureSet(&[_]Feature{
            .avr2,
            .lpmx,
        }),
    };
    pub const attiny261 = CpuModel{
        .name = "attiny261",
        .llvm_name = "attiny261",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny261a = CpuModel{
        .name = "attiny261a",
        .llvm_name = "attiny261a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny28 = CpuModel{
        .name = "attiny28",
        .llvm_name = "attiny28",
        .features = featureSet(&[_]Feature{
            .avr1,
        }),
    };
    pub const attiny4 = CpuModel{
        .name = "attiny4",
        .llvm_name = "attiny4",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny40 = CpuModel{
        .name = "attiny40",
        .llvm_name = "attiny40",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny4313 = CpuModel{
        .name = "attiny4313",
        .llvm_name = "attiny4313",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny43u = CpuModel{
        .name = "attiny43u",
        .llvm_name = "attiny43u",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny44 = CpuModel{
        .name = "attiny44",
        .llvm_name = "attiny44",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny44a = CpuModel{
        .name = "attiny44a",
        .llvm_name = "attiny44a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny45 = CpuModel{
        .name = "attiny45",
        .llvm_name = "attiny45",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny461 = CpuModel{
        .name = "attiny461",
        .llvm_name = "attiny461",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny461a = CpuModel{
        .name = "attiny461a",
        .llvm_name = "attiny461a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny48 = CpuModel{
        .name = "attiny48",
        .llvm_name = "attiny48",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny5 = CpuModel{
        .name = "attiny5",
        .llvm_name = "attiny5",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const attiny828 = CpuModel{
        .name = "attiny828",
        .llvm_name = "attiny828",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny84 = CpuModel{
        .name = "attiny84",
        .llvm_name = "attiny84",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny84a = CpuModel{
        .name = "attiny84a",
        .llvm_name = "attiny84a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny85 = CpuModel{
        .name = "attiny85",
        .llvm_name = "attiny85",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny861 = CpuModel{
        .name = "attiny861",
        .llvm_name = "attiny861",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny861a = CpuModel{
        .name = "attiny861a",
        .llvm_name = "attiny861a",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny87 = CpuModel{
        .name = "attiny87",
        .llvm_name = "attiny87",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny88 = CpuModel{
        .name = "attiny88",
        .llvm_name = "attiny88",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const attiny9 = CpuModel{
        .name = "attiny9",
        .llvm_name = "attiny9",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const atxmega128a1 = CpuModel{
        .name = "atxmega128a1",
        .llvm_name = "atxmega128a1",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega128a1u = CpuModel{
        .name = "atxmega128a1u",
        .llvm_name = "atxmega128a1u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128a3 = CpuModel{
        .name = "atxmega128a3",
        .llvm_name = "atxmega128a3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega128a3u = CpuModel{
        .name = "atxmega128a3u",
        .llvm_name = "atxmega128a3u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128a4u = CpuModel{
        .name = "atxmega128a4u",
        .llvm_name = "atxmega128a4u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128b1 = CpuModel{
        .name = "atxmega128b1",
        .llvm_name = "atxmega128b1",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128b3 = CpuModel{
        .name = "atxmega128b3",
        .llvm_name = "atxmega128b3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128c3 = CpuModel{
        .name = "atxmega128c3",
        .llvm_name = "atxmega128c3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega128d3 = CpuModel{
        .name = "atxmega128d3",
        .llvm_name = "atxmega128d3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega128d4 = CpuModel{
        .name = "atxmega128d4",
        .llvm_name = "atxmega128d4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega16a4 = CpuModel{
        .name = "atxmega16a4",
        .llvm_name = "atxmega16a4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega16a4u = CpuModel{
        .name = "atxmega16a4u",
        .llvm_name = "atxmega16a4u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega16c4 = CpuModel{
        .name = "atxmega16c4",
        .llvm_name = "atxmega16c4",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega16d4 = CpuModel{
        .name = "atxmega16d4",
        .llvm_name = "atxmega16d4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega16e5 = CpuModel{
        .name = "atxmega16e5",
        .llvm_name = "atxmega16e5",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega192a3 = CpuModel{
        .name = "atxmega192a3",
        .llvm_name = "atxmega192a3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega192a3u = CpuModel{
        .name = "atxmega192a3u",
        .llvm_name = "atxmega192a3u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega192c3 = CpuModel{
        .name = "atxmega192c3",
        .llvm_name = "atxmega192c3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega192d3 = CpuModel{
        .name = "atxmega192d3",
        .llvm_name = "atxmega192d3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega256a3 = CpuModel{
        .name = "atxmega256a3",
        .llvm_name = "atxmega256a3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega256a3b = CpuModel{
        .name = "atxmega256a3b",
        .llvm_name = "atxmega256a3b",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega256a3bu = CpuModel{
        .name = "atxmega256a3bu",
        .llvm_name = "atxmega256a3bu",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega256a3u = CpuModel{
        .name = "atxmega256a3u",
        .llvm_name = "atxmega256a3u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega256c3 = CpuModel{
        .name = "atxmega256c3",
        .llvm_name = "atxmega256c3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega256d3 = CpuModel{
        .name = "atxmega256d3",
        .llvm_name = "atxmega256d3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega32a4 = CpuModel{
        .name = "atxmega32a4",
        .llvm_name = "atxmega32a4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega32a4u = CpuModel{
        .name = "atxmega32a4u",
        .llvm_name = "atxmega32a4u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega32c4 = CpuModel{
        .name = "atxmega32c4",
        .llvm_name = "atxmega32c4",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega32d4 = CpuModel{
        .name = "atxmega32d4",
        .llvm_name = "atxmega32d4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega32e5 = CpuModel{
        .name = "atxmega32e5",
        .llvm_name = "atxmega32e5",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega32x1 = CpuModel{
        .name = "atxmega32x1",
        .llvm_name = "atxmega32x1",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega384c3 = CpuModel{
        .name = "atxmega384c3",
        .llvm_name = "atxmega384c3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega384d3 = CpuModel{
        .name = "atxmega384d3",
        .llvm_name = "atxmega384d3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega64a1 = CpuModel{
        .name = "atxmega64a1",
        .llvm_name = "atxmega64a1",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega64a1u = CpuModel{
        .name = "atxmega64a1u",
        .llvm_name = "atxmega64a1u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64a3 = CpuModel{
        .name = "atxmega64a3",
        .llvm_name = "atxmega64a3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega64a3u = CpuModel{
        .name = "atxmega64a3u",
        .llvm_name = "atxmega64a3u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64a4u = CpuModel{
        .name = "atxmega64a4u",
        .llvm_name = "atxmega64a4u",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64b1 = CpuModel{
        .name = "atxmega64b1",
        .llvm_name = "atxmega64b1",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64b3 = CpuModel{
        .name = "atxmega64b3",
        .llvm_name = "atxmega64b3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64c3 = CpuModel{
        .name = "atxmega64c3",
        .llvm_name = "atxmega64c3",
        .features = featureSet(&[_]Feature{
            .xmegau,
        }),
    };
    pub const atxmega64d3 = CpuModel{
        .name = "atxmega64d3",
        .llvm_name = "atxmega64d3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega64d4 = CpuModel{
        .name = "atxmega64d4",
        .llvm_name = "atxmega64d4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const atxmega8e5 = CpuModel{
        .name = "atxmega8e5",
        .llvm_name = "atxmega8e5",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avr1 = CpuModel{
        .name = "avr1",
        .llvm_name = "avr1",
        .features = featureSet(&[_]Feature{
            .avr1,
        }),
    };
    pub const avr2 = CpuModel{
        .name = "avr2",
        .llvm_name = "avr2",
        .features = featureSet(&[_]Feature{
            .avr2,
        }),
    };
    pub const avr25 = CpuModel{
        .name = "avr25",
        .llvm_name = "avr25",
        .features = featureSet(&[_]Feature{
            .avr25,
        }),
    };
    pub const avr3 = CpuModel{
        .name = "avr3",
        .llvm_name = "avr3",
        .features = featureSet(&[_]Feature{
            .avr3,
        }),
    };
    pub const avr31 = CpuModel{
        .name = "avr31",
        .llvm_name = "avr31",
        .features = featureSet(&[_]Feature{
            .avr31,
        }),
    };
    pub const avr35 = CpuModel{
        .name = "avr35",
        .llvm_name = "avr35",
        .features = featureSet(&[_]Feature{
            .avr35,
        }),
    };
    pub const avr4 = CpuModel{
        .name = "avr4",
        .llvm_name = "avr4",
        .features = featureSet(&[_]Feature{
            .avr4,
        }),
    };
    pub const avr5 = CpuModel{
        .name = "avr5",
        .llvm_name = "avr5",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
    pub const avr51 = CpuModel{
        .name = "avr51",
        .llvm_name = "avr51",
        .features = featureSet(&[_]Feature{
            .avr51,
        }),
    };
    pub const avr6 = CpuModel{
        .name = "avr6",
        .llvm_name = "avr6",
        .features = featureSet(&[_]Feature{
            .avr6,
        }),
    };
    pub const avrtiny = CpuModel{
        .name = "avrtiny",
        .llvm_name = "avrtiny",
        .features = featureSet(&[_]Feature{
            .avrtiny,
        }),
    };
    pub const avrxmega1 = CpuModel{
        .name = "avrxmega1",
        .llvm_name = "avrxmega1",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega2 = CpuModel{
        .name = "avrxmega2",
        .llvm_name = "avrxmega2",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega3 = CpuModel{
        .name = "avrxmega3",
        .llvm_name = "avrxmega3",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega4 = CpuModel{
        .name = "avrxmega4",
        .llvm_name = "avrxmega4",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega5 = CpuModel{
        .name = "avrxmega5",
        .llvm_name = "avrxmega5",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega6 = CpuModel{
        .name = "avrxmega6",
        .llvm_name = "avrxmega6",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const avrxmega7 = CpuModel{
        .name = "avrxmega7",
        .llvm_name = "avrxmega7",
        .features = featureSet(&[_]Feature{
            .xmega,
        }),
    };
    pub const m3000 = CpuModel{
        .name = "m3000",
        .llvm_name = "m3000",
        .features = featureSet(&[_]Feature{
            .avr5,
        }),
    };
};