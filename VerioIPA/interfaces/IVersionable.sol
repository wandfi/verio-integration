// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title Versionable Interface
/// @notice Interface for managing the version of a contract
interface IVersionable {
    /// @notice Event emitted when the version is updated
    /// @param version The version of the deployed implementation
    event VersionUpdated(string indexed version);

    /// @notice Error emitted when the next version is invalid
    error NextVersionInvalid(string currentVersion, string nextVersion);

    /// @notice Gets the version of the deployed implementation
    /// @return The version of the deployed implementation
    function getVersion() external view returns (string memory);
}
