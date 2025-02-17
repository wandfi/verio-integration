// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title ICreator Interface
/// @notice Interface for the creator contract
interface ICreator {
    /// @notice State of the creator
    /// @param creatorAddress Address of the creator
    /// @param isIncentivePoolCreator Whether the creator is an incentive pool creator
    struct CreatorState {
        address creatorAddress;
        bool isIncentivePoolCreator;
    }

    /// @notice Event emitted when a creator is registered
    /// @param creatorAddress Address of the creator
    event CreatorRegistered(address indexed creatorAddress);

    /// @notice Event emitted when a creator is updated
    /// @param creatorAddress Address of the creator
    event CreatorUpdated(address indexed creatorAddress);
}
