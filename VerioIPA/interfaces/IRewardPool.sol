// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title IRewardPool Interface
/// @notice Interface for the reward pool contract
interface IRewardPool {
    /// @notice Enum for the reward token type
    enum RewardTokenType {
        ERC20,
        NATIVE
    }

    /// @notice Enum for the distribution type
    enum DistributionType {
        CONTINUOUS,
        STATIC
    }

    /// @notice State for the reward pool
    /// @param rewardToken Address of the reward token
    /// @param rewardTokenType Type of reward token
    /// @param distributionType Distribution type
    /// @param rewardsPerEpoch Rewards per epoch
    /// @param rewardPerToken Reward per token
    /// @param totalRewards Total rewards
    /// @param totalDistributedRewards Total distributed rewards
    /// @param lastEpochBlock Last epoch block
    struct RewardPoolState {
        address rewardToken;
        RewardTokenType rewardTokenType;
        DistributionType distributionType;
        uint256 rewardsPerEpoch;
        uint256 rewardPerToken;
        uint256 totalRewards;
        uint256 totalDistributedRewards;
        uint256 lastEpochBlock;
    }

    /// @notice Details about a specific reward
    /// @param rewardToken Address of the reward token
    /// @param rewardTokenType Type of reward token
    /// @param rewardAmount Reward amount
    struct RewardDetail {
        address rewardToken;
        RewardTokenType rewardTokenType;
        uint256 rewardAmount;
    }

    /// @notice Configuration for the reward pool
    /// @param rewardToken Address of the reward token
    /// @param rewardTokenType Type of reward token
    /// @param distributionType Distribution type
    /// @param rewardsPerEpoch Rewards per epoch
    struct RewardPoolConfig {
        address rewardToken;
        RewardTokenType rewardTokenType;
        DistributionType distributionType;
        uint256 rewardsPerEpoch;
    }

    /// @notice Event emitted when a reward pool is created
    /// @param rewardToken Address of the reward token
    /// @param rewardTokenType Type of reward token
    /// @param distributionType Distribution type
    /// @param rewardsPerEpoch Rewards per epoch
    event RewardPoolCreated(
        address rewardToken, RewardTokenType rewardTokenType, DistributionType distributionType, uint256 rewardsPerEpoch
    );
}
