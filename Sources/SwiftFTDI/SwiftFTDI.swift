import clibftdi
import Foundation

public class FTDI {
    public enum ChipType: UInt32 {
        case _AM
        case _BM
        case _2232C
        case _R
        case _2232H
        case _4232H
        case _232H
        case _230X

        public var rawValue: UInt32 {
            switch self {
            case ._AM: return TYPE_AM.rawValue
            case ._BM: return TYPE_BM.rawValue
            case ._2232C: return TYPE_2232C.rawValue
            case ._R: return TYPE_R.rawValue
            case ._2232H: return TYPE_2232H.rawValue
            case ._4232H: return TYPE_4232H.rawValue
            case ._232H: return TYPE_232H.rawValue
            case ._230X: return TYPE_230X.rawValue
            }
        }
    }

    public enum ParityType: UInt32 {
        case none
        case odd
        case even
        case mark
        case space

        public var rawValue: UInt32 {
            switch self {
            case .none: return NONE.rawValue
            case .odd: return ODD.rawValue
            case .even: return EVEN.rawValue
            case .mark: return MARK.rawValue
            case .space: return SPACE.rawValue
            }
        }
    }

    public enum StopbitsType: UInt32 {
        case _1
        case _15
        case _2

        public var rawValue: UInt32 {
            switch self {
            case ._1: return STOP_BIT_1.rawValue
            case ._15: return STOP_BIT_15.rawValue
            case ._2: return STOP_BIT_2.rawValue
            }
        }
    }

    public enum BitsType: UInt32 {
        case _7
        case _8

        public var rawValue: UInt32 {
            switch self {
            case ._7: return BITS_7.rawValue
            case ._8: return BITS_8.rawValue
            }
        }
    }

    public enum BreakType: UInt32 {
        case off
        case on

        public var rawValue: UInt32 {
            switch self {
            case .off: return BREAK_OFF.rawValue
            case .on: return BREAK_ON.rawValue
            }
        }
    }

    // MPSSE mode
    public enum Bitmode: UInt8 {
        case reset
        case bitbang
        case mpsse
        case syncbb
        case mcu
        case opto
        case cbus
        case syncff
        case ft1284

        public var rawValue: UInt8 {
            switch self {
            case .reset: return UInt8(BITMODE_RESET.rawValue)
            case .bitbang: return UInt8(BITMODE_BITBANG.rawValue)
            case .mpsse: return UInt8(BITMODE_MPSSE.rawValue)
            case .syncbb: return UInt8(BITMODE_SYNCBB.rawValue)
            case .mcu: return UInt8(BITMODE_MCU.rawValue)
            case .opto: return UInt8(BITMODE_OPTO.rawValue)
            case .cbus: return UInt8(BITMODE_CBUS.rawValue)
            case .syncff: return UInt8(BITMODE_SYNCFF.rawValue)
            case .ft1284: return UInt8(BITMODE_FT1284.rawValue)
            }
        }
    }

    public enum Interface: UInt32 {
        case any
        case A
        case B
        case C
        case D

        public var rawValue: UInt32 {
            switch self {
            case .any: return INTERFACE_ANY.rawValue
            case .A: return INTERFACE_A.rawValue
            case .B: return INTERFACE_B.rawValue
            case .C: return INTERFACE_C.rawValue
            case .D: return INTERFACE_D.rawValue
            }
        }

        var ftdiInterface: ftdi_interface {
            return ftdi_interface(self.rawValue)
        }
    }

    public enum ModuleDetachMode: UInt32 {
        case autoDetachSioModule
        case dontDetachSioModule

        public var rawValue: UInt32 {
            switch self {
            case .autoDetachSioModule: return AUTO_DETACH_SIO_MODULE.rawValue
            case .dontDetachSioModule: return DONT_DETACH_SIO_MODULE.rawValue
            }
        }
    }

    public enum Commands {
        public enum MPSSE {
            public static let writeNeg = MPSSE_WRITE_NEG
            public static let bitmode = MPSSE_BITMODE
            public static let readNeg = MPSSE_READ_NEG
            public static let lsb = MPSSE_LSB
            public static let doWrite = MPSSE_DO_WRITE
            public static let doRead = MPSSE_DO_READ
            public static let writeTMS = MPSSE_WRITE_TMS
        }

        public static let setBitsLow = UInt8(SET_BITS_LOW)
        public static let setBitsHigh = UInt8(SET_BITS_HIGH)
        public static let getBitsLow = UInt8(GET_BITS_LOW)
        public static let getBitsHigh = UInt8(GET_BITS_HIGH)
        public static let loopbackStart = UInt8(LOOPBACK_START)
        public static let loopbackEnd = UInt8(LOOPBACK_END)
        public static let tckDivisor = TCK_DIVISOR

        public static let disDiv5 = UInt8(DIS_DIV_5)
        public static let enDiv5 = UInt8(EN_DIV_5)
        public static let en3phase = EN_3_PHASE
        public static let clkBits = CLK_BITS
        public static let clkBytes = CLK_BYTES
        public static let clkWaitHigh = CLK_WAIT_HIGH
        public static let clkWaitLow = CLK_WAIT_LOW
        public static let enAdaptive = EN_ADAPTIVE
        public static let disAdaptive = DIS_ADAPTIVE
        public static let clkBytesOrHigh = CLK_BYTES_OR_HIGH
        public static let clkBytesOrLow = CLK_BYTES_OR_LOW

        public static let driveOpenCollector = DRIVE_OPEN_COLLECTOR

        public static let sendImmediate = UInt8(SEND_IMMEDIATE)
        public static let waitOnHigh = WAIT_ON_HIGH
        public static let waitOnLow = WAIT_ON_LOW

        public static let readShort = UInt8(READ_SHORT)
        public static let readExtended = UInt8(READ_EXTENDED)

        public static let writeShort = UInt8(WRITE_SHORT)
        public static let writeExtended = UInt8(WRITE_EXTENDED)

        public enum FlowControl {
            public static let sioReset = SIO_RESET
            public static let sioModemCtrl = SIO_MODEM_CTRL
            public static let sioSetFlowCtrl = SIO_SET_FLOW_CTRL
            public static let sioSetBaudRate = SIO_SET_BAUD_RATE
            public static let sioSetData = SIO_SET_DATA
        }

        public enum Requests {
            public static let sioReset = SIO_RESET_REQUEST
            public static let sioSetBaudrate = SIO_SET_BAUDRATE_REQUEST
            public static let sioSetData = SIO_SET_DATA_REQUEST
            public static let sioSetFlowCtrl = SIO_SET_FLOW_CTRL_REQUEST
            public static let sioSetModemCtrl = SIO_SET_MODEM_CTRL_REQUEST
            public static let sioPollModemStatus = SIO_POLL_MODEM_STATUS_REQUEST
            public static let sioSetEventChar = SIO_SET_EVENT_CHAR_REQUEST
            public static let sioSetErrorChar = SIO_SET_ERROR_CHAR_REQUEST
            public static let sioSetLatencyTimer = SIO_SET_LATENCY_TIMER_REQUEST
            public static let sioGetLatencyTimer = SIO_GET_LATENCY_TIMER_REQUEST
            public static let sioSetBitmode = SIO_SET_BITMODE_REQUEST
            public static let sioReadPins = SIO_READ_PINS_REQUEST
            public static let sioReadEEPROM = SIO_READ_EEPROM_REQUEST
            public static let sioWriteEEPROM = SIO_WRITE_EEPROM_REQUEST
            public static let sioEraseEEPROM = SIO_ERASE_EEPROM_REQUEST
        }

        public static let sioResetSio = SIO_RESET_SIO

        public static let sioSetRtsMask = SIO_SET_RTS_MASK
        public static let sioEraseEEPROM = SIO_RTS_CTS_HS
    }

    public func divValue(rate: UInt32) -> UInt32 {
        return (rate > 6000000) ? 0 : ( (6000000/rate - 1) > 0xffff) ? 0xffff : (6000000/rate - 1)
    }

    public enum EEPROMValue: UInt32 {
        case vendorId
        case productId
        case selfPowered
        case remoteWakeup
        case isNotPNP
        case suspendDBUS7
        case inIsIsochronous
        case outIsIsochronous
        case suspenPullDowns
        case useSerial
        case usbVersion
        case useUsbVersion
        case maxPower
        case channelAType
        case channelBType
        case channelADriver
        case channelBDriver
        case cbusFunction0
        case cbusFunction1
        case cbusFunction2
        case cbusFunction3
        case cbusFunction4
        case cbusFunction5
        case cbusFunction6
        case cbusFunction7
        case cbusFunction8
        case cbusFunction9
        case highCurrent
        case highCurrentA
        case highCurrentB
        case invert
        case group0Drive
        case group0Schmitt
        case group0Slew
        case group1Drive
        case group1Schmitt
        case group1Slew
        case group2Drive
        case group2Schmitt
        case group2Slew
        case group3Drive
        case group3Schmitt
        case group3Slew
        case chipSize
        case chipType
        case powerSave
        case clockPolarity
        case dataOrder
        case flowControl
        case channelCDriver
        case channelDDriver
        case channelARS485
        case channelBRS485
        case channelCRS485
        case channelDRS485
        case releaseNumber
        case externalOscillator

        public var rawValue: UInt32 {
            switch self {
            case .vendorId: return VENDOR_ID.rawValue
            case .productId: return PRODUCT_ID.rawValue
            case .selfPowered: return SELF_POWERED.rawValue
            case .remoteWakeup: return REMOTE_WAKEUP.rawValue
            case .isNotPNP: return IS_NOT_PNP.rawValue
            case .suspendDBUS7: return SUSPEND_DBUS7.rawValue
            case .inIsIsochronous: return IN_IS_ISOCHRONOUS.rawValue
            case .outIsIsochronous: return OUT_IS_ISOCHRONOUS.rawValue
            case .suspenPullDowns: return SUSPEND_PULL_DOWNS.rawValue
            case .useSerial: return USE_SERIAL.rawValue
            case .usbVersion: return USB_VERSION.rawValue
            case .useUsbVersion: return USE_USB_VERSION.rawValue
            case .maxPower: return MAX_POWER.rawValue
            case .channelAType: return CHANNEL_A_TYPE.rawValue
            case .channelBType: return CHANNEL_B_TYPE.rawValue
            case .channelADriver: return CHANNEL_A_DRIVER.rawValue
            case .channelBDriver: return CHANNEL_B_DRIVER.rawValue
            case .cbusFunction0: return CBUS_FUNCTION_0.rawValue
            case .cbusFunction1: return CBUS_FUNCTION_1.rawValue
            case .cbusFunction2: return CBUS_FUNCTION_2.rawValue
            case .cbusFunction3: return CBUS_FUNCTION_3.rawValue
            case .cbusFunction4: return CBUS_FUNCTION_4.rawValue
            case .cbusFunction5: return CBUS_FUNCTION_5.rawValue
            case .cbusFunction6: return CBUS_FUNCTION_6.rawValue
            case .cbusFunction7: return CBUS_FUNCTION_7.rawValue
            case .cbusFunction8: return CBUS_FUNCTION_8.rawValue
            case .cbusFunction9: return CBUS_FUNCTION_9.rawValue
            case .highCurrent: return HIGH_CURRENT.rawValue
            case .highCurrentA: return HIGH_CURRENT_A.rawValue
            case .highCurrentB: return HIGH_CURRENT_B.rawValue
            case .invert: return INVERT.rawValue
            case .group0Drive: return GROUP0_DRIVE.rawValue
            case .group0Schmitt: return GROUP0_SCHMITT.rawValue
            case .group0Slew: return GROUP0_SLEW.rawValue
            case .group1Drive: return GROUP1_DRIVE.rawValue
            case .group1Schmitt: return GROUP1_SCHMITT.rawValue
            case .group1Slew: return GROUP1_SLEW.rawValue
            case .group2Drive: return GROUP2_DRIVE.rawValue
            case .group2Schmitt: return GROUP2_SCHMITT.rawValue
            case .group2Slew: return GROUP2_SLEW.rawValue
            case .group3Drive: return GROUP3_DRIVE.rawValue
            case .group3Schmitt: return GROUP3_SCHMITT.rawValue
            case .group3Slew: return GROUP3_SLEW.rawValue
            case .chipSize: return CHIP_SIZE.rawValue
            case .chipType: return CHIP_TYPE.rawValue
            case .powerSave: return POWER_SAVE.rawValue
            case .clockPolarity: return CLOCK_POLARITY.rawValue
            case .dataOrder: return DATA_ORDER.rawValue
            case .flowControl: return FLOW_CONTROL.rawValue
            case .channelCDriver: return CHANNEL_C_DRIVER.rawValue
            case .channelDDriver: return CHANNEL_D_DRIVER.rawValue
            case .channelARS485: return CHANNEL_A_RS485.rawValue
            case .channelBRS485: return CHANNEL_B_RS485.rawValue
            case .channelCRS485: return CHANNEL_C_RS485.rawValue
            case .channelDRS485: return CHANNEL_D_RS485.rawValue
            case .releaseNumber: return RELEASE_NUMBER.rawValue
            case .externalOscillator: return EXTERNAL_OSCILLATOR.rawValue
            }
        }


    };

    public enum FlowControl: Int32 {
        case disable
        case rtsCtsHs
        case dtrDtsHs
        case xonXoffHs

        public var rawValue: Int32 {
            switch self {
            case .disable: return SIO_DISABLE_FLOW_CTRL
            case .rtsCtsHs: return SIO_RTS_CTS_HS
            case .dtrDtsHs: return SIO_DTR_DSR_HS
            case .xonXoffHs: return SIO_XON_XOFF_HS
            }
        }
    }

    public struct VersionInfo {
        public let major: Int32
        public let minor: Int32
        public let micro: Int32
        public let versionStr: String
        public let snapshotStr: String

        init(_ info: ftdi_version_info) {
            self.major = info.major
            self.minor = info.minor
            self.micro = info.micro
            self.versionStr = String(cString: info.version_str)
            self.snapshotStr = String(cString: info.snapshot_str)
        }
    }

    public struct FTDIDevice {
        public let vendor: Int32
        public let product: Int32
        public let manufacturer: String
        public let description: String
        public let serialNumber: String
    }

    private let context: UnsafeMutablePointer<ftdi_context>!

    public init() throws {
        guard let context = ftdi_new() else {
            throw SwiftFTDIError.ftdiContextCreationFailed
        }
        self.context = context
        let ret = ftdi_init(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiCouldntAllocateReadBuffer
        case -2: throw SwiftFTDIError.ftdiCouldntAllocateStructBuffer
        case -3: throw SwiftFTDIError.usbLibusbInitFailed
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    deinit {
        ftdi_deinit(context)
        ftdi_free(context)
    }


    public func setInterface(_ interface: Interface) throws {
        let ret = ftdi_set_interface(context,  interface.ftdiInterface)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiUnknownInterface
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        case -3: throw SwiftFTDIError.usbDeviceAlreadyOpen
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func getLibraryVersion() -> VersionInfo {
        VersionInfo(ftdi_get_library_version())
    }

    public func usbFindAll(vendor: Int32, product: Int32) -> [FTDIDevice] {
        var list: UnsafeMutablePointer<ftdi_device_list>?

        ftdi_usb_find_all(context, &list, vendor, product)
        defer {
            ftdi_list_free(&list)
        }

        guard var ftdiList = list?.pointee else { return [] }

        var result: [FTDIDevice] = []

        while true {
            let bufferLength: Int32 = 256
            let manufacturerBuf = UnsafeMutablePointer<Int8>.allocate(capacity: Int(bufferLength))
            let descriptionBuf = UnsafeMutablePointer<Int8>.allocate(capacity: Int(bufferLength))
            let serialBuf = UnsafeMutablePointer<Int8>.allocate(capacity: Int(bufferLength))

            ftdi_usb_get_strings(context, ftdiList.dev, manufacturerBuf, bufferLength, descriptionBuf, bufferLength, serialBuf, bufferLength)
            let device = FTDIDevice(
                vendor: vendor,
                product: product,
                manufacturer: String(cString: manufacturerBuf),
                description: String(cString: descriptionBuf),
                serialNumber:String(cString: serialBuf)
            )

            result.append(device)
            guard let next = ftdiList.next else { break }
            ftdiList = next.pointee
        }

        return result
    }

    public func usbOpenDescIndex(
        vendor: Int32? = nil,
        product: Int32? = nil,
        description: String? = nil,
        serial: String? = nil,
        index: UInt32 = 0
    ) throws {
        let ret = ftdi_usb_open_desc_index(
            context,
            vendor ?? 0,
            product ?? 0,
            description,
            serial,
            index
        )
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.usbFindBussesFailed
        case -2: throw SwiftFTDIError.usbFindDevicesFailed
        case -3: throw SwiftFTDIError.usbDeviceNotFound
        case -4: throw SwiftFTDIError.usbUnableToOpenDevice
        case -5: throw SwiftFTDIError.usbUnableToClaimDevice
        case -6: throw SwiftFTDIError.usbResetFailed
        case -7: throw SwiftFTDIError.ftdiSetBaudrateFailed
        case -8: throw SwiftFTDIError.usbGetProductDescriptionFailed
        case -9: throw SwiftFTDIError.usbGetSerialNumberFailed
        case -10: throw SwiftFTDIError.usbUnableToCloseDevice
        case -11: throw SwiftFTDIError.ftdiContextInvalid
        case -12: throw SwiftFTDIError.usbGetDeviceListFailed
        case -13: throw SwiftFTDIError.usbGetDeviceDescriptorFailed
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    @discardableResult
    public func writeData(_ data: Data) throws -> Int32  {
        let count = Int32(data.count)
        var ret: Int32 = 0
        data.withUnsafeBytes { ptr in
            let buf = ptr.bindMemory(to: UInt8.self)
            ret = ftdi_write_data(self.context, buf.baseAddress!, count)
        }
        switch ret {
        case -666: throw SwiftFTDIError.usbDeviceUnavailable
        case ..<0: throw SwiftFTDIError.usbBulkWriteFailed(ret)
        default: return ret
        }
    }

    public func readData(count: Int) throws -> Data {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: count)
        result.initialize(repeating: 0, count: count)
        defer { result.deallocate() }
        let ret = ftdi_read_data(self.context, result, Int32(count))
        switch ret {
        case -666: throw SwiftFTDIError.usbDeviceUnavailable
        case ..<0: throw SwiftFTDIError.usbBulkTransferFailed(ret)
        default: break
        }
        return Data(bytes: result, count: count)
    }

    public func writeDataSetChunksize(_ chunksize: UInt32) throws {
        let ret = ftdi_write_data_set_chunksize(context, chunksize)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiContextInvalid
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func writeDataGetChunksize() throws -> UInt32 {
        let result = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_write_data_get_chunksize(context, result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiContextInvalid
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func readDataSetChunksize(_ chunksize: UInt32) throws {
        let ret = ftdi_read_data_set_chunksize(context, chunksize)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiContextInvalid
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func readDataGetChunksize() throws -> UInt32 {
        let result = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_read_data_get_chunksize(context, result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiContextInvalid
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func setBitmode(bitmask: UInt8, mode: Bitmode) throws {
        let ret = ftdi_set_bitmode(context, bitmask, mode.rawValue)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiCantEnableBitbangMode
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func disableBitbang() throws {
        let ret = ftdi_disable_bitbang(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiCantDisableBitbangMode
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func tcioFlush() throws {
        let ret = ftdi_tcioflush(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiReadBufferPurgeFailed
        case -2: throw SwiftFTDIError.ftdiWriteBufferPurgeFailed
        case -3: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func readPins() throws -> UInt8 {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_read_pins(context, result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiReadPinsFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func setLatencyTimer(_ latency: UInt8) throws {
        let ret = ftdi_set_latency_timer(context, latency)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiLatencyOutOfRange(latency)
        case -2: throw SwiftFTDIError.ftdiUnableToSetLatencyTimer
        case -3: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setBaudrate(_ baudrate: Int32) throws {
        let ret = ftdi_set_baudrate(context, baudrate)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiInvalidBaudrate(baudrate)
        case -2: throw SwiftFTDIError.ftdiSetBaudrateFailed
        case -3: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func getLatencyTimer() throws -> UInt8 {
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_get_latency_timer(context, result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiUnableToGetLatencyTimer
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func pollModemStatus() throws -> UInt16 {
        let result = UnsafeMutablePointer<UInt16>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_poll_modem_status(context, result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiUnableToRetrieveStatusInformation
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func setFlowCtl(_ flowControl: FlowControl) throws {
        let ret = ftdi_setflowctrl(context, flowControl.rawValue)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiSetFlowControlFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setDtr(_ high: Bool) throws {
        let mask = ((high ? 1 : 0) | ( SIO_SET_DTR_MASK  << 8))
        let ret = ftdi_setdtr(context, mask)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiSetDtrFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setRts(_ high: Bool) throws {
        let mask = ((high ? 1 : 0) | ( SIO_SET_RTS_MASK  << 8))
        let ret = ftdi_setrts(context, mask)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiSetRtsFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setDtrRts(_ dtrHigh: Bool, _ rtsHigh: Bool) throws {
        let dtrMask = ((dtrHigh ? 1 : 0) | ( SIO_SET_DTR_MASK  << 8))
        let rtsMask = ((rtsHigh ? 1 : 0) | ( SIO_SET_RTS_MASK  << 8))
        let ret = ftdi_setdtr_rts(context, dtrMask, rtsMask)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiSetDtrRtsFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setEventChar(_ char: UInt8, enabled: Bool) throws {
        let ret = ftdi_set_event_char(context, char, enabled ? 1 : 0)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiUnableToSetEventCharacter
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setErrorChar(_ char: UInt8, enabled: Bool) throws {
        let ret = ftdi_set_error_char(context, char, enabled ? 1 : 0)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiUnableToSetErrorCharacter
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func eepromInitDefaults(manufacturer: String, product: String, serial: String) throws {
        var manufacturerString = manufacturer.cString(using: .utf8) ?? []
        var productString = product.cString(using: .utf8) ?? []
        var serialString = serial.cString(using: .utf8) ?? []
        var ret: Int32 = 0
        manufacturerString.withUnsafeMutableBytes { manufacturerBuf in
            productString.withUnsafeMutableBytes { productBuf in
                serialString.withUnsafeMutableBytes { serialBuf in
                    ret = ftdi_eeprom_initdefaults(
                        context,
                        manufacturerBuf.baseAddress!,
                        productBuf.baseAddress!,
                        serialBuf.baseAddress!
                    )
                }
            }
        }
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiNoStructFTDIContext
        case -2: throw SwiftFTDIError.ftdiNoStructFTDIEEPROM
        case -3: throw SwiftFTDIError.ftdiNoConnectedDeviceOrNotYetOpened
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func getEepromValue(type: EEPROMValue) throws -> Int32 {
        let result = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
        defer { result.deallocate() }
        let ret = ftdi_get_eeprom_value(context, ftdi_eeprom_value(rawValue: type.rawValue), result)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiEEPROMValueDoesntExist
        default: throw SwiftFTDIError.unknown(ret)
        }
        return result.pointee
    }

    public func readEEPROM() throws {
        let ret = ftdi_read_eeprom(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiEEPROMReadFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func eraseEEPROM() throws {
        let ret = ftdi_erase_eeprom(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiEEPROMEraseFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        case -3: throw SwiftFTDIError.ftdiEEPROMWritingMagicFailed
        case -4: throw SwiftFTDIError.ftdiEEPROMReadFailed
        case -5: throw SwiftFTDIError.ftdiEEPROMUnexpectedValue
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func setEEPROMValue(type: EEPROMValue, value: Int32) throws {
        let ret = ftdi_set_eeprom_value(context, ftdi_eeprom_value(rawValue: type.rawValue), value)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiEEPROMValueDoesntExist
        case -2: throw SwiftFTDIError.ftdiEEPROMValueIsntUserSettable
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func EEPROMBuild() throws -> Int32 {
        let ret = ftdi_eeprom_build(context)
        switch ret {
        case 0...: return ret
        case -1: throw SwiftFTDIError.ftdiEEPROMSizeExceededByCustomStrings
        case -2: throw SwiftFTDIError.ftdiInvalidEEPROMOrFTDIPointer
        case -3: throw SwiftFTDIError.ftdiEEPROMInvalidCBUSFunctionSetting
        case -4: throw SwiftFTDIError.ftdiEEPROMChipDoesntSupportInvert
        case -5: throw SwiftFTDIError.ftdiEEPROMChipDoesntSupportHighCurrentDrive
        case -6: throw SwiftFTDIError.ftdiEEPROMNoConnectedOrUnknownType
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func writeEEPROM() throws {
        let ret = ftdi_write_eeprom(context)
        switch ret {
        case 0: break
        case -1: throw SwiftFTDIError.ftdiEEPROMWriteFailed
        case -2: throw SwiftFTDIError.usbDeviceUnavailable
        case -3: throw SwiftFTDIError.ftdiEEPROMInvalidAccessToChecksumProtectedArea
        case -4: throw SwiftFTDIError.ftdiEEPROMDeviceCantAccessUnprotectedArea
        case -5: throw SwiftFTDIError.ftdiEEPROMReadingChipTypeFailed
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

    public func decodeEEPROM(verbose: Bool) throws {
        let ret = ftdi_eeprom_decode(context, verbose ? 0 : 1)
        switch ret {
        case 0: break
        default: throw SwiftFTDIError.unknown(ret)
        }
    }

}

extension FTDI {
    public func writePins(_ pins: UInt8) throws {
        try writeData(Data(repeating: pins, count: 1))
    }
}
