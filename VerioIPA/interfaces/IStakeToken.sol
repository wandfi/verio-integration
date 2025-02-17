// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title IStakeToken Interface
/// @notice Interface for the stake token contract
interface IStakeToken {
    /// @notice Enum for the stake token type
    enum Type {
        NATIVE,
        ERC20
    }

    /// @notice Event emitted when the stake token is updated
    /// @param stakeTokenAddress Address of the stake token
    /// @param minStakeAmount Minimum stake amount
    /// @param stakeTokenType Type of stake token
    event StakeTokenUpdated(address stakeTokenAddress, uint256 minStakeAmount, Type stakeTokenType);

    /// @notice Gets the price of the stake token in IP
    /// @param _amount Amount of stake token
    /// @return Price in IP
    function priceInIP(uint256 _amount) external view returns (uint256);

    /// @notice Gets the stake token address
    /// @return Address of the stake token
    function getStakeToken() external view returns (address);

    /// @notice Gets the minimum stake amount
    /// @return Minimum stake amount
    function getMinStakeAmount() external view returns (uint256);

    /// @notice Gets the stake token type
    /// @return Type of stake token
    function getStakeTokenType() external view returns (Type);
}
