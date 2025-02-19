// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import "./IVersionable.sol";

/// @title Insurance Pool Interface
/// @notice Interface for managing an insurance pool that provides coverage for other components
/// @dev This interface defines the core functionality for insurance pool operations
/// @notice State for insurance pool
/// @param claimant Address of the supported claimant
/// @param targetInsurancePool Target amount to maintain in the insurance pool
struct InsurancePoolState {
    address claimant;
    uint256 targetInsurancePool;
}

interface IInsurancePool is IVersionable {

    /// @notice Emitted when insurance is claimed from the pool
    /// @param recipient Address receiving the insurance claim
    /// @param amount Amount of insurance claimed (in IP)
    event InsuranceClaimed(address recipient, uint256 amount);

    /// @notice Emitted when the insurance pool receives funding
    /// @param amount Amount of funds added to the pool (in IP)
    event InsurancePoolFunded(uint256 amount);

    /// @notice Emitted when the insurance pool is updated
    /// @param insurancePoolState The new insurance pool state
    event InsurancePoolStateUpdated(InsurancePoolState insurancePoolState);

    /// @notice Emitted when the admin withdraws funds from the insurance pool
    /// @param admin Address of the admin
    /// @param amount Amount of funds withdrawn from the pool (in IP)
    event InsuranceWithdrawn(address admin, uint256 amount);

    /// @notice Error when claimant address is invalid
    error InvalidClaimantAddress();

    /// @notice Error when target insurance pool is invalid
    error InvalidTargetInsurancePool();

    /// @notice Error when insufficient funds in the insurance pool
    /// @param requested The requested amount
    /// @param available The available balance
    error InsufficientFunds(uint256 requested, uint256 available);

    /// @notice Error when only claimant can call function
    /// @param claimant The authorized claimant address
    error OnlyClaimant(address claimant);

    /// @notice Error when funds transfer fails
    /// @param recipient The address that should receive the funds
    /// @param amount The amount that failed to transfer
    error TransferFailed(address recipient, uint256 amount);

    /// @notice Allows direct funding of the insurance pool
    function fund() external payable;

    /// @notice Calculates the current debt (shortfall) of the insurance pool
    /// @return Amount of debt/shortfall in the insurance pool (in IP)
    function getDebt() external view returns (uint256);

    /// @notice Gets the total balance of the insurance pool
    /// @return Current balance of the insurance pool (in IP)
    function getTotal() external view returns (uint256);

    /// @notice Gets the target amount for the insurance pool
    /// @return Target amount that should be maintained in the pool (in IP)
    function getTarget() external view returns (uint256);
}
