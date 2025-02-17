// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IIPAssetStaking} from "./IIPAssetStaking.sol";
import {IIPAssetRegistry} from "./Story/IIPAssetRegistry.sol";
import {IVerioIPStakePool} from "./VerioIP/IVerioIPStakePool.sol";
import {IVersionable} from "./IVersionable.sol";
import {ILockup} from "./ILockup.sol";
import {IOperatorRegistry} from "./IOperatorRegistry.sol";
import {ICreatorRegistry} from "./ICreatorRegistry.sol";
import {IIPAssetStakePoolRegistry} from "./IIPAssetStakePoolRegistry.sol";

/// @title Component Selector Interface
/// @notice Manages references to all upgradeable components in the system
/// @dev Provides centralized version management and component addressing
interface IComponentSelector is IVersionable {
    /// @notice Emitted when a component address is updated
    /// @param componentName Name of the updated component
    /// @param oldAddress Previous address of the component
    /// @param oldVersion Version of the component before the update
    /// @param newAddress New address of the component
    /// @param newVersion Version of the component after the update
    event ComponentUpdated(
        string componentName, address oldAddress, string oldVersion, address newAddress, string newVersion
    );

    /// @notice Error emitted when the component address is invalid
    error InvalidComponent(address component);

    /// @notice Gets the IP asset staking contract
    /// @return Address of the IP asset staking contract
    function ipAssetStaking() external view returns (IIPAssetStaking);

    /// @notice Gets the IP asset registry contract
    /// @return Address of the IP asset registry contract
    function ipAssetRegistry() external view returns (IIPAssetRegistry);

    /// @notice Gets the VerioIP stake pool contract
    /// @return Address of the VerioIP stake pool contract
    function verioIPStakePool() external view returns (IVerioIPStakePool);

    /// @notice Gets the lockup contract
    /// @return Address of the lockup contract
    function lockup() external view returns (ILockup);

    /// @notice Gets the operator registry contract
    /// @return Address of the operator registry contract
    function operatorRegistry() external view returns (IOperatorRegistry);

    /// @notice Gets the creator registry contract
    /// @return Address of the creator registry contract
    function creatorRegistry() external view returns (ICreatorRegistry);

    /// @notice Gets the IP asset stake pool registry contract
    /// @return Address of the IP asset stake pool registry contract
    function ipAssetStakePoolRegistry() external view returns (IIPAssetStakePoolRegistry);

    /// @notice Gets the semantic version of a component
    /// @param _component Address of the component
    /// @return version SemanticVersion of the component
    function getComponentVersion(address _component) external view returns (string memory);
}
