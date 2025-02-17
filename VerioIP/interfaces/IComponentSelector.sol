// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import "./IStakePool.sol";
import "./IInsurancePool.sol";
import "./IDelegator.sol";
import "./IWithdrawalPool.sol";
import "./IRewardPool.sol";
import "./IVerioIP.sol";
import "./IVerioComponent.sol";
import "./IVersionable.sol";
import "./Story/IIPTokenStaking.sol";

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

    /// @notice Emitted when an insurance pool address is updated for a component
    /// @param componentAddress Address of the component
    /// @param insurancePoolAddress New address of the insurance pool
    event ComponentInsurancePoolUpdated(address componentAddress, address insurancePoolAddress);

    /// @notice Error when component address is invalid
    error InvalidComponentAddress();

    /// @notice Error when address is not a Verio component
    error AddressNotVerioComponent();

    /// @notice Error when funds are sent to the contract
    error NoFundsAccepted();

    /// @notice Gets the current stake pool implementation
    /// @return Address of the current stake pool contract
    function stakePool() external view returns (IStakePool);

    /// @notice Gets the current IP token staking implementation
    /// @return Address of the current IP token staking contract
    function ipTokenStaking() external view returns (IIPTokenStaking);

    /// @notice Gets the current insurance pool implementation
    /// @return Address of the current insurance pool contract
    function insurancePoolByComponent(address _componentAddress) external view returns (IInsurancePool);

    /// @notice Gets the current delegator implementation
    /// @return Address of the current delegator contract
    function delegator() external view returns (IDelegator);

    /// @notice Gets the current withdrawal pool implementation
    /// @return Address of the current withdrawal pool contract
    function withdrawalPool() external view returns (IWithdrawalPool);

    /// @notice Gets the current reward pool implementation
    /// @return Address of the current reward pool contract
    function rewardPool() external view returns (IRewardPool);

    /// @notice Gets the current VerioIP token implementation
    /// @return Address of the current VerioIP token contract
    function verioIP() external view returns (IVerioIP);

    /// @notice Gets the semantic version of a component
    /// @param _component Address of the component
    /// @return version SemanticVersion of the component
    function getComponentVersion(address _component) external view returns (string memory);
}
