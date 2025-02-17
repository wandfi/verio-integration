// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IVersionable} from "../IVersionable.sol";

interface IVerioIPStakePool is IVersionable {
    /// @notice Calculates amount of vIP to mint for a given IP amount
    /// @param _ipAmount Amount of IP to calculate vIP for
    /// @return Amount of vIP that would be minted
    function calculateVIPMint(uint256 _ipAmount) external view returns (uint256);

    /// @notice Calculates amount of IP to withdraw for a given vIP amount
    /// @param _vIPToBurn Amount of vIP to calculate IP withdrawal for
    /// @return Amount of IP that would be withdrawn
    function calculateIPWithdrawal(uint256 _vIPToBurn) external view returns (uint256);
}
