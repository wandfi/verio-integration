// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title IOperator Interface
/// @notice Interface for the operator contract
interface IOperator {
    /// @notice Event emitted when an operator is registered
    /// @param operatorAddress Address of the operator
    /// @param commissionFee Commission fee for the operator
    /// @param rewardsAddress Address of the rewards address
    event OperatorRegistered(address indexed operatorAddress, uint256 commissionFee, address rewardsAddress);

    /// @notice Event emitted when an operator is updated
    /// @param operatorAddress Address of the operator
    /// @param commissionFee Commission fee for the operator
    /// @param rewardsAddress Address of the rewards address
    event OperatorUpdated(address indexed operatorAddress, uint256 commissionFee, address rewardsAddress);
}
