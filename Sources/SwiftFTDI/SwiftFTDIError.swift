import Foundation

public enum SwiftFTDIError: Error {
    public enum USBErrorKind {
        case findBussesFailed
        case findDevicesFailed
        case unableToOpenDevice
        case unableToClaimDevice
        case deviceNotFound
        case deviceUnavailable
        case bulkWriteFailed(Int32)
        case bulkTransferFailed(Int32)
        case libusbInitFailed
        case resetFailed
        case getProductDescriptionFailed
        case getSerialNumberFailed
        case unableToCloseDevice
        case getDeviceListFailed
        case getDeviceDescriptorFailed
        case deviceAlreadyOpen
    }
    case usb(USBErrorKind)

    case ftdiUnknownInterface
    case ftdiEEPROMInvalidAccessToChecksumProtectedArea
    case ftdiEEPROMDeviceCantAccessUnprotectedArea
    case ftdiEEPROMReadingChipTypeFailed
    case ftdiEEPROMSizeExceededByCustomStrings
    case ftdiInvalidEEPROMOrFTDIPointer
    case ftdiEEPROMInvalidCBUSFunctionSetting
    case ftdiEEPROMChipDoesntSupportInvert
    case ftdiEEPROMChipDoesntSupportHighCurrentDrive
    case ftdiEEPROMNoConnectedOrUnknownType
    case ftdiEEPROMWritingMagicFailed
    case ftdiEEPROMUnexpectedValue
    case ftdiEEPROMEraseFailed
    case ftdiEEPROMReadFailed
    case ftdiEEPROMWriteFailed
    case ftdiEEPROMValueDoesntExist
    case ftdiEEPROMValueIsntUserSettable
    case ftdiNoStructFTDIContext
    case ftdiNoStructFTDIEEPROM
    case ftdiNoConnectedDeviceOrNotYetOpened
    case ftdiUnableToSetEventCharacter
    case ftdiUnableToSetErrorCharacter
    case ftdiSetDtrFailed
    case ftdiSetRtsFailed
    case ftdiSetDtrRtsFailed
    case ftdiCouldntAllocateReadBuffer
    case ftdiCouldntAllocateStructBuffer
    case ftdiContextCreationFailed
    case ftdiInitializationFailed
    case ftdiCantEnableBitbangMode
    case ftdiCantDisableBitbangMode
    case ftdiReadPinsFailed
    case ftdiReadBufferPurgeFailed
    case ftdiWriteBufferPurgeFailed
    case ftdiLatencyOutOfRange(UInt8)
    case ftdiUnableToSetLatencyTimer
    case ftdiSetFlowControlFailed
    case ftdiUnableToRetrieveStatusInformation
    case ftdiUnableToGetLatencyTimer
    case ftdiSetBaudrateFailed
    case ftdiInvalidBaudrate(Int32)
    case ftdiContextInvalid

    case unknown(Int32)
}
