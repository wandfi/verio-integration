// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IOperator} from "./IOperator.sol";
import {IVersionable} from "./IVersionable.sol";

interface IOperatorRegistry is IVersionable {
    /// @notice Event emitted when an operator is registered
    /// @param operatorAddress Address of the operator
    /// @param commissionFee Commission fee for the operator
    /// @param rewardsAddress Address of the rewards address
    event OperatorRegistered(address indexed operatorAddress, uint256 commissionFee, address rewardsAddress);

    /// @notice Event emitted when an operator is deregistered
    /// @param operatorAddress Address of the operator
    event OperatorDeregistered(address indexed operatorAddress);

    /// @notice Event emitted when an operator is updated
    /// @param operatorAddress Address of the operator
    /// @param commissionFee Commission fee for the operator
    /// @param rewardsAddress Address of the rewards address
    event OperatorUpdated(address indexed operatorAddress, uint256 commissionFee, address rewardsAddress);

    /// @notice Event emitted when the operator update fee is updated
    /// @param operatorUpdateFee New operator update fee
    event OperatorUpdateFeeUpdated(uint256 operatorUpdateFee);

    /// @notice Error emitted when an operator is invalid
    /// @param operator Address of the operator
    error InvalidOperator(address operator);

    /// @notice Error emitted when an operator is already registered
    /// @param operator Address of the operator
    error OperatorAlreadyRegistered(address operator);

    /// @notice Error emitted when an operator commission fee is too high
    /// @param commissionFee Commission fee
    error OperatorCommissionTooHigh(uint256 commissionFee);

    /// @notice Error emitted when an operator fee is unpaid
    /// @param fee Fee
    error OperatorFeeUnpaid(uint256 fee);

    /// @notice Error emitted when an operator rewards address is invalid
    /// @param rewardsAddress Rewards address
    error InvalidRewardsAddress(address rewardsAddress);

    /// @notice Error emitted when the operator update fee is failed to send
    /// @param fee Fee
    /// @param treasuryAddress Address of the treasury
    error FailedToSendOperatorUpdateFee(uint256 fee, address treasuryAddress);

    /// @notice Register an operator
    /// @param _operatorConfig Configuration for the operator
    // function registerOperator(IOperator.OperatorConfig calldata _operatorConfig) external;

    /// @notice Deregister an operator
    /// @param _operatorAddress Address of the operator
    function deregisterOperator(address _operatorAddress) external;

    /// @notice Check if an operator is registered
    /// @param _operator Address of the operator
    /// @return True if the operator is registered, false otherwise
    function isOperator(address _operator) external view returns (bool);

    /// @notice Set the commission fee for an operator
    /// @param _operator Address of the operator
    /// @param _commissionFee Commission fee
    function setOperatorCommissionFee(address _operator, uint256 _commissionFee) external payable;

    /// @notice Set the rewards address for an operator
    /// @param _operator Address of the operator
    /// @param _rewardsAddress Rewards address
    function setOperatorRewardsAddress(address _operator, address _rewardsAddress) external payable;

    /// @notice Get the state of an operator
    /// @param _operator Address of the operator
    /// @return State of the operator
    // function getOperatorState(address _operator) external view returns (IOperator.OperatorState memory);

    /// @notice Get the commission fee for an operator
    /// @param _operator Address of the operator
    /// @return Commission fee
    function getOperatorCommissionFee(address _operator) external view returns (uint256);

    /// @notice Get the rewards address for an operator
    /// @param _operator Address of the operator
    /// @return Rewards address
    function getOperatorRewardsAddress(address _operator) external view returns (address);

    /// @notice Get the update fee for an operator
    /// @return Update fee
    function getOperatorUpdateFee() external view returns (uint256);
}
