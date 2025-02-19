// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IStakeToken} from "./IStakeToken.sol";
import {IStakePool, UserStakeAmountDetail} from "./IStakePool.sol";
import {ILockup} from "./ILockup.sol";
import {IIncentivePool} from "./IIncentivePool.sol";
import {IRewardPool} from "./IRewardPool.sol";
import {IOperator} from "./IOperator.sol";
import {IVersionable} from "./IVersionable.sol";
import {IIPAssetRegistry} from "./Story/IIPAssetRegistry.sol";

/// @title IIPAssetStaking Interface
/// @notice Interface for the IP asset staking contract
/// @dev This interface extends the IVersionable interface to allow for versioning
interface IIPAssetStaking is IVersionable {
    /// @notice Event emitted when an IP asset is registered
    /// @param ipAsset Address of the IP asset
    /// @param stakePool Address of the stake pool
    event IPAssetRegistered(address indexed ipAsset, address indexed stakePool);

    /// @notice Error emitted when an IP asset is invalid
    /// @param ipAsset Address of the IP asset
    error InvalidIPAsset(address ipAsset);

    /// @notice Error emitted when an IP asset is not registered with the IP asset registry
    /// @param ipAsset Address of the IP asset
    /// @param ipAssetRegistry Address of the IP asset registry
    error IPAssetNotRegisteredWithIPAssetRegistry(address ipAsset, address ipAssetRegistry);

    /// @notice Error emitted when an IP asset is already registered
    /// @param ipAsset Address of the IP asset
    error IPAssetAlreadyRegistered(address ipAsset);

    /// @notice Error emitted when a stake token is invalid
    /// @param stakeToken Address of the stake token
    error InvalidStakeToken(address stakeToken);

    /// @notice Error emitted when a stake token amount is invalid
    /// @param stakeToken Address of the stake token
    /// @param amount Amount of tokens
    error InvalidStakeTokenAmount(address stakeToken, uint256 amount);

    /// @notice Error emitted when a stake token is already registered
    /// @param stakeToken Address of the stake token
    error StakeTokenAlreadyRegistered(address stakeToken);

    /// @notice Error emitted when a native token transfer fails
    /// @param to Address of the recipient
    /// @param amount Amount of tokens
    error NativeTokenTransferFailed(address to, uint256 amount);

    /// @notice Error emitted when a stake pool is empty
    /// @param stakePool Address of the stake pool
    error StakePoolEmpty(address stakePool);

    /// @notice Error emitted when an incentive pool creator mismatch
    /// @param creator Address of the creator
    /// @param incentivePoolCreator Address of the incentive pool creator
    error IncentivePoolCreatorMismatch(address creator, address incentivePoolCreator);

    /// @notice Error emitted when an invalid reward token amount is provided
    /// @param rewardToken Address of the reward token
    /// @param amount Amount of tokens
    error InvalidRewardTokenAmount(address rewardToken, uint256 amount);

    /// @notice Error emitted when an invalid native reward token address is provided
    /// @param rewardToken Address of the reward token
    /// @dev Native reward tokens should always be indicated by address(0)
    error InvalidNativeRewardTokenAddress(address rewardToken);

    /// @notice Error emitted when an invalid rewards per epoch is provided
    /// @param rewardsPerEpoch Rewards per epoch
    error InvalidRewardsPerEpoch(uint256 rewardsPerEpoch);

    /// @notice Error emitted when the maximum number of incentive pools is reached
    /// @param ipAsset Address of the IP asset
    /// @param maxIncentivePools Maximum number of incentive pools
    error MaxIncentivePoolsReached(address ipAsset, uint256 maxIncentivePools);

    /// @notice Error emitted when the maximum number of reward pools is reached
    /// @param ipAsset Address of the IP asset
    /// @param maxRewardPools Maximum number of reward pools
    error MaxRewardPoolsReached(address ipAsset, uint256 maxRewardPools);

    /// @notice Error emitted when the maximum number of incentive pools is invalid
    /// @param maxIncentivePools Maximum number of incentive pools
    error InvalidMaxIncentivePools(uint256 maxIncentivePools);

    /// @notice Error emitted when the maximum number of reward pools is invalid
    /// @param maxRewardPools Maximum number of reward pools
    error InvalidMaxRewardPools(uint256 maxRewardPools);

    /// @notice Error emitted when the unstake fee is invalid
    /// @param unstakeFeeBps Unstake fee in bps
    error InvalidUnstakeFeeBps(uint256 unstakeFeeBps);

    /// @notice Error emitted when the maximum unstake fee is invalid
    /// @param maxUnstakeFeeBps Maximum unstake fee in bps
    error InvalidMaxUnstakeFeeBps(uint256 maxUnstakeFeeBps);

    /// @notice Registers an IP asset, and creates default stake pools, incentive pools, and reward pools
    /// @param _ipAsset Address of the IP asset
    /// @return Address of the stake pool associated with the IP asset
    function registerIPAsset(address _ipAsset) external returns (address);

    /// @notice Stakes tokens for an IP asset
    /// @param _ipAsset Address of the IP asset
    /// @param _stakeTokenAddress Address of the stake token
    /// @param _amount Amount of tokens to stake
    /// @param _type Type of lockup
    function stake(address _ipAsset, address _stakeTokenAddress, uint256 _amount, ILockup.Type _type)
        external
        payable;

    /// @notice Stakes tokens for an IP asset on behalf of another user
    /// @param _ipAsset Address of the IP asset
    /// @param _stakeTokenAddress Address of the stake token
    /// @param _amount Amount of tokens to stake
    /// @param _type Type of lockup
    /// @param _user Address of the user
    function stakeOnBehalf(
        address _ipAsset,
        address _stakeTokenAddress,
        uint256 _amount,
        ILockup.Type _type,
        address _user
    ) external payable;

    /// @notice Unstakes tokens for an IP asset
    /// @param _ipAsset Address of the IP asset
    /// @param _stakeTokenAddress Address of the stake token
    /// @param _amount Amount of tokens to unstake
    /// @param _type Type of lockup
    function unstake(address _ipAsset, address _stakeTokenAddress, uint256 _amount, ILockup.Type _type) external;

    /// @notice Unstakes tokens for an IP asset on behalf of another user
    /// @param _ipAsset Address of the IP asset
    /// @param _stakeTokenAddress Address of the stake token
    /// @param _amount Amount of tokens to unstake
    /// @param _type Type of lockup
    /// @param _user Address of the user
    function unstakeOnBehalf(
        address _ipAsset,
        address _stakeTokenAddress,
        uint256 _amount,
        ILockup.Type _type,
        address _user
    ) external;

    /// @notice Registers an incentive pool
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolConfig Configuration for the incentive pool
    // function registerIncentivePool(address _ipAsset, IIncentivePool.IncentivePoolConfig calldata _incentivePoolConfig)
    //     external;

    /// @notice Registers a reward pool
    /// @param _ipAsset Address of the IP asset
    /// @param _rewardPoolConfig Configuration for the reward pool
    function registerRewardPool(address _ipAsset, IRewardPool.RewardPoolConfig calldata _rewardPoolConfig) external;

    /// @notice Registers a stake token
    /// @param _stakeToken Stake token to register
    function registerStakeToken(IStakeToken _stakeToken) external;

    /// @notice Gets the reward pools for an incentive pool creator
    /// @param _ipAsset Address of the IP asset
    /// @return Reward pools for the incentive pool creator
    function getRewardPools(address _ipAsset) external view returns (IRewardPool.RewardPoolState[][] memory);

    /// @notice Gets the reward pools for an incentive pool creator
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Reward pools for the incentive pool creator
    function getRewardPoolsByIncentivePoolCreator(address _ipAsset, address _incentivePoolCreator)
        external
        view
        returns (IRewardPool.RewardPoolState[] memory);

    /// @notice Gets the total stake priced in IP across all IP assets
    /// @return Total stake priced in IP across all IP assets
    function getTotalStakePricedInIP() external view returns (uint256);

    /// @notice Gets the total stake weighted by lockup periods for an IP asset.
    /// @return Total stake weighted by lockup peirods for an IP asset.
    function getTotalStakeWeightedInIPForIP(address _ipAsset) external view returns (uint256);

    /// @notice Adds rewards to an incentive pool
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @param _amount Amount of rewards to add
    /// @param _rewardToken Address of the reward token
    function addRewards(address _ipAsset, address _incentivePoolCreator, uint256 _amount, address _rewardToken)
        external
        payable;

    /// @notice Claims rewards for an IP asset
    /// @param _ipAsset Address of the IP asset
    function claimRewards(address _ipAsset) external;

    /// @notice Claims rewards for an IP asset on behalf of another user
    /// @param _ipAsset Address of the IP asset
    /// @param _user Address of the user
    function claimRewardsOnBehalf(address _ipAsset, address _user) external;

    /// @notice Claims rewards for an incentive pool
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    function claimRewardsForIncentivePool(address _ipAsset, address _incentivePoolCreator) external;

    /// @notice Claims rewards for an incentive pool on behalf of another user
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @param _user Address of the user
    function claimRewardsForIncentivePoolOnBehalf(address _ipAsset, address _incentivePoolCreator, address _user)
        external;

    /// @notice Calculates the rewards for a user
    /// @param _user Address of the user
    /// @param _ipAsset Address of the IP asset
    /// @return Rewards for the user
    function calculateUserRewards(address _user, address _ipAsset)
        external
        view
        returns (IRewardPool.RewardDetail[][] memory);

    /// @notice Calculates user rewards from staking with operator
    /// @param _operator Address of the operator
    /// @param _user Address of the user
    /// @param _ipAsset Address of the IP asset
    /// @return Rewards information
    function calculateUserRewardsFromOperator(address _operator, address _user, address _ipAsset)
        external
        view
        returns (IRewardPool.RewardDetail[][] memory);

    /// @notice Calculates the rewards for a user
    /// @param _user Address of the user
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Rewards for the user
    function calculateUserRewardsForIncentivePool(address _user, address _ipAsset, address _incentivePoolCreator)
        external
        view
        returns (IRewardPool.RewardDetail[] memory);

    /// @notice Calculates user rewards
    /// @param _operator Address of the operator
    /// @param _user Address of the user
    /// @param _ipAsset Address of the IP asset
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Rewards information
    function calculateUserRewardsFromOperatorForIncentivePool(
        address _operator,
        address _user,
        address _ipAsset,
        address _incentivePoolCreator
    ) external view returns (IRewardPool.RewardDetail[] memory);

    /// @notice Gets the user's stake amount for an IP asset
    /// @param _ipAsset Address of the IP asset
    /// @param _user Address of the user
    /// @return Stake amount for the user
    function getUserStakeAmountForIP(address _ipAsset, address _user)
        external
        view
        returns (UserStakeAmountDetail[][] memory);

    /// @notice Gets the total stake amount for an IP asset for an array of stakeTokens
    /// @param _ipAsset Address of the IP asset
    /// @param _stakeTokens addresses of the stake tokens
    /// @return Stake amount for the stakepool
    function getTotalStakeAmountForIP(address _ipAsset, address[] calldata _stakeTokens)
        external
        view
        returns (uint256[] memory);

    /// @notice Gets the user's stake amount for an IP asset for a lockup type
    /// @param _ipAsset Address of the IP asset
    /// @param _lockup Type of lockup
    /// @param _user Address of the user
    /// @return Stake amount for the user
    function getUserStakeAmountForIPForLockup(address _ipAsset, ILockup.Type _lockup, address _user)
        external
        view
        returns (UserStakeAmountDetail[] memory);

    /// @notice Gets the user's last stake block for an IP asset for a lockup type
    /// @param _ipAsset Address of the IP asset
    /// @param _lockup Type of lockup
    /// @param _user Address of the user
    /// @return Last stake timestamp for the user
    function getUserLastStakeTimestampForIPForLockup(address _ipAsset, ILockup.Type _lockup, address _user)
        external
        view
        returns (uint256);

    /// @notice Gets the maximum number of incentive pools
    /// @return Maximum number of incentive pools
    function getMaxIncentivePools() external view returns (uint256);

    /// @notice Gets the maximum number of reward pools
    /// @return Maximum number of reward pools
    function getMaxRewardPools() external view returns (uint256);

    /// @notice Gets the unstake fee
    /// @return Unstake fee
    function getUnstakeFeeBps() external view returns (uint256);

    /// @notice Gets the maximum unstake fee
    /// @return Maximum unstake fee
    function getMaxUnstakeFeeBps() external view returns (uint256);
}
