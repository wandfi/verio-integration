// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IRewardPool} from "./IRewardPool.sol";
import {IStakePool} from "./IStakePool.sol";

/// @title IIncentivePool Interface
/// @notice Interface for the incentive pool
interface IIncentivePool {
    /// @notice Event emitted when an incentive pool is created
    /// @param creator Address of the creator
    /// @param epochDuration Duration of an epoch (in blocks)
    event IncentivePoolCreated(address indexed creator, uint256 epochDuration);

    /// @notice Event emitted when a reward pool is registered
    /// @param rewardToken Address of the reward token
    event RewardPoolRegistered(address indexed rewardToken);

    /// @notice Event emitted when rewards are added
    /// @param rewardToken Address of the reward token
    /// @param amount Amount of rewards added
    event RewardsAdded(address indexed rewardToken, uint256 amount);

    /// @notice Event emitted when rewards are claimed
    /// @param user Address of the user
    /// @param rewardToken Address of the reward token
    /// @param amount Amount of rewards claimed
    event RewardsClaimed(address indexed user, address indexed rewardToken, uint256 amount);

    /// @notice Event emitted when a reward token transfer fails
    /// @param recipient Address of the recipient
    /// @param amount Amount of reward token
    /// @param rewardToken Address of the reward token
    /// @param rewardTokenType Type of reward token
    /// @param data Data from the transfer
    event RewardTokenTransferFailed(
        address recipient, uint256 amount, address rewardToken, IRewardPool.RewardTokenType rewardTokenType, bytes data
    );

    /// @notice Error emitted when the maximum number of reward tokens is reached
    error MaxRewardTokensReached(uint256 maxRewardTokens);

    /// @notice Error emitted when the reward token type is invalid
    error InvalidRewardTokenType(IRewardPool.RewardTokenType rewardTokenType);

    /// @notice Error emitted when a native token transfer fails
    error NativeTokenTransferFailed(address receiver);

    /// @notice Calculates the user's reward amount for a given reward token
    /// @param _userStakeInIP User's stake in the incentive pool
    /// @param _userRewardPerToken User's reward per token
    /// @param _totalStakedInPool Total staked in the incentive pool
    /// @param _rewardToken Address of the reward token
    /// @return Amount of rewards for the user
    function calculateUserRewardAmountForRewardToken(
        uint256 _userStakeInIP,
        uint256 _userRewardPerToken,
        uint256 _totalStakedInPool,
        address _rewardToken
    ) external view returns (uint256);

    /// @notice Gets the reward pools
    /// @return Array of reward pools
    function getRewardPools() external view returns (IRewardPool.RewardPoolState[] memory);

    /// @notice Gets the reward pool by reward token
    /// @param _rewardToken Address of the reward token
    /// @return Reward pool
    function getRewardPoolByRewardToken(address _rewardToken)
        external
        view
        returns (IRewardPool.RewardPoolState memory);

    /// @notice Gets the reward per token for a reward pool
    /// @param _rewardToken Address of the reward token
    /// @return Reward per token
    function getRewardPerTokenForRewardPool(address _rewardToken) external view returns (uint256);

    /// @notice Gets the number of reward pools
    /// @return Number of reward pools
    function getNumRewardPools() external view returns (uint256);
}
