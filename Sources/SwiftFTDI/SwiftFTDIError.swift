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

    public enum FTDIErrorKind {
        case unknownInterface
        case eepromInvalidAccessToChecksumProtectedArea
        case eepromDeviceCantAccessUnprotectedArea
        case eepromReadingChipTypeFailed
        case eepromSizeExceededByCustomStrings
        case invalidEEPROMOrFTDIPointer
        case eepromInvalidCBUSFunctionSetting
        case eepromChipDoesntSupportInvert
        case eepromChipDoesntSupportHighCurrentDrive
        case eepromNoConnectedOrUnknownType
        case eepromWritingMagicFailed
        case eepromUnexpectedValue
        case eepromEraseFailed
        case eepromReadFailed
        case eepromWriteFailed
        case eepromValueDoesntExist
        case eepromValueIsntUserSettable
        case noStructFTDIContext
        case noStructFTDIEEPROM
        case noConnectedDeviceOrNotYetOpened
        case unableToSetEventCharacter
        case unableToSetErrorCharacter
        case setDtrFailed
        case setRtsFailed
        case setDtrRtsFailed
        case couldntAllocateReadBuffer
        case couldntAllocateStructBuffer
        case contextCreationFailed
        case initializationFailed
        case cantEnableBitbangMode
        case cantDisableBitbangMode
        case readPinsFailed
        case readBufferPurgeFailed
        case writeBufferPurgeFailed
        case latencyOutOfRange(UInt8)
        case unableToSetLatencyTimer
        case setFlowControlFailed
        case unableToRetrieveStatusInformation
        case unableToGetLatencyTimer
        case setBaudrateFailed
        case invalidBaudrate(Int32)
        case contextInvalid
    }
    case ftdi(FTDIErrorKind)
    case unknown(Int32)
}
