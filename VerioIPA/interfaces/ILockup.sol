// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IVersionable} from "./IVersionable.sol";

/// @title ILockup Interface
/// @notice Interface for the lockup contract
interface ILockup is IVersionable {
    /// @notice Enum for the lockup type
    enum Type {
        INSTANT, // 0
        SHORT, // 1
        LONG // 2

    }

    /// @notice Struct for the lockup
    /// @param lockupType Type of lockup
    /// @param multiplier Multiplier for the lockup
    /// @param period Period for the lockup
    struct Lockup {
        Type lockupType;
        uint256 multiplier;
        uint256 period;
    }

    /// @notice Event emitted when a lockup is added
    /// @param _lockupType Type of lockup
    /// @param _lockupPeriod Period for the lockup
    /// @param _lockupMultiplier Multiplier for the lockup
    event LockupAdded(Type _lockupType, uint256 _lockupPeriod, uint256 _lockupMultiplier);

    /// @notice Event emitted when a lockup update is prepared
    /// @param _lockupType Type of lockup
    /// @param _lockupPeriod Period for the lockup
    /// @param _lockupMultiplier Multiplier for the lockup
    event LockupUpdatePrepared(Type _lockupType, uint256 _lockupPeriod, uint256 _lockupMultiplier);

    /// @notice Event emitted when a lockup update is committed
    /// @param _lockupType Type of lockup
    /// @param _lockupPeriod Period for the lockup
    /// @param _lockupMultiplier Multiplier for the lockup
    event LockupUpdateCommitted(Type _lockupType, uint256 _lockupPeriod, uint256 _lockupMultiplier);

    /// @notice Event emitted when a lockup update is cancelled
    /// @param _lockupType Type of lockup
    event LockupUpdateCancelled(Type _lockupType);

    /// @notice Error emitted when a lockup is not passed
    /// @param lockupEndBlock End block for the lockup
    error LockupNotPassed(uint256 lockupEndBlock);

    /// @notice Error emitted when a lockup is invalid
    /// @param lockupPeriod Period for the lockup
    /// @param lockupMultiplier Multiplier for the lockup
    error InvalidLockup(uint256 lockupPeriod, uint256 lockupMultiplier);

    /// @notice Error emitted when the maximum lockup period is invalid
    /// @param maxLockupPeriod Maximum lockup period
    error InvalidMaxLockupPeriod(uint256 maxLockupPeriod);

    /// @notice Error emitted when a lockup update is already pending
    /// @param _lockupType Type of lockup
    error LockupUpdateAlreadyPending(Type _lockupType);

    /// @notice Error emitted when a lockup update is not pending
    /// @param _lockupType Type of lockup
    error LockupUpdateNotPending(Type _lockupType);

    /// @notice Error emitted when a lockup already exists
    /// @param _lockupType Type of lockup
    error LockupAlreadyExists(Type _lockupType);

    /// @notice Gets the lockup types
    /// @return Array of lockup types
    function getLockupTypes() external view returns (Type[] memory);

    /// @notice Gets the lockup by type
    /// @param _lockupType Type of lockup
    /// @return Lockup state
    function getLockupByType(Type _lockupType) external view returns (Lockup memory);

    /// @notice Gets the lockup period
    /// @param _lockupType Type of lockup
    /// @return Period for the lockup
    function getLockupPeriod(Type _lockupType) external view returns (uint256);

    /// @notice Gets the maximum lockup period
    /// @return Maximum lockup period
    function getMaxLockupPeriod() external view returns (uint256);

    /// @notice Gets the lockup multiplier
    /// @param _lockupType Type of lockup
    /// @return Multiplier for the lockup
    function getLockupMultiplier(Type _lockupType) external view returns (uint256);
}
