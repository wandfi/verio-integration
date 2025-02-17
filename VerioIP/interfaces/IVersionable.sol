// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title Versionable Interface
/// @notice Interface for managing the version of a contract
interface IVersionable {
    /// @notice Event emitted when the version is updated
    /// @param version The new version
    event VersionUpdated(string indexed version);

    /// @notice Error when the version is invalid
    error InvalidVersion();

    /// @notice Gets the version of the deployed implementation
    function getVersion() external view returns (string memory);
}
