// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {IStakeToken} from "./IStakeToken.sol";
import {IIncentivePool} from "./IIncentivePool.sol";
import {ILockup} from "./ILockup.sol";
import {IRewardPool} from "./IRewardPool.sol";
import {IComponentSelector} from "./IComponentSelector.sol";


/// @notice State for the stake pool
/// @param ipAsset Address of the IP asset
/// @param stakeByOperatorUser Mapping of operators to their corresponding user stakes
/// @param totalStakePerStakeTokenByLockup Mapping of lockup types to their corresponding total stake per stake token
/// @param stakeTokens Array of stake tokens
/// @param incentivePoolsByCreators Mapping of creators to their corresponding incentive pools
/// @param incentivePoolCreators Array of creators
/// @param selector Address of the component selector
struct StakePoolState {
    address ipAsset;
    // mapping(address => UserStake) stakeByUser;
    mapping(address => mapping(address => UserStake)) stakeByOperatorUser;
    mapping(ILockup.Type => mapping(IStakeToken => uint256)) totalStakePerStakeTokenByLockup;
    mapping(IStakeToken => bool) isStakeTokenStaked;
    IStakeToken[] stakeTokens;
    mapping(address => IIncentivePool) incentivePoolsByCreators;
    mapping(address => bool) incentivePoolRegisteredForCreator;
    mapping(address => mapping(address => bool)) rewardPoolRegisteredForCreator;
    address[] incentivePoolCreators;
    IComponentSelector selector;
}

/// @notice Configuration for the stake pool
/// @param ipAsset Address of the IP asset
struct StakePoolConfig {
    address ipAsset;
}

/// @param rewardPerTokenByRewardToken Reward tokens to their corresponding reward per token
/// @param rewardsClaimed Rewards tokens to the total amount of rewards claimed
struct RewardInfoForStake {
    uint256 rewardPerTokenByRewardToken;
    uint256 rewardsClaimed;
}

/// @notice State for the user stake
/// @param rewardPerTokenByRewardToken Mapping of reward tokens to their corresponding reward per token
/// @param userPeriodBasedStake Mapping of lockup types to their corresponding user period based stake
struct UserStake {
    mapping(address => mapping(address => RewardInfoForStake)) rewardsDetail; // ipoolcreator => rewardtoken => RewardDetails
    mapping(ILockup.Type => UserPeriodBasedStake) userPeriodBasedStake;
}

/// @notice State for the user period based stake
/// @param stakeByToken Mapping of stake tokens to their corresponding stake
/// @param stakeTokens Array of stake tokens
/// @param lastStakeTimestamp Last stake timestamp
struct UserPeriodBasedStake {
    mapping(IStakeToken => uint256) stakeByToken;
    mapping(IStakeToken => bool) isStakeTokenStaked;
    IStakeToken[] stakeTokens;
    uint256 lastStakeTimestamp;
}

/// @notice State for the user stake amount detail
/// @param stakeTokenAddress Address of the stake token
/// @param amount Amount of stake
/// @param lockup Type of lockup
/// @param lastStakeTimestamp Last stake timestamp
struct UserStakeAmountDetail {
    address stakeTokenAddress;
    uint256 amount;
    ILockup.Type lockup;
    uint256 lastStakeTimestamp;
}

/// @title IStakePool Interface
/// @notice Interface for the stake pool contract
interface IStakePool {

    /// @notice Event emitted when a stake pool is created
    /// @param ipAsset Address of the IP asset
    event StakePoolCreated(address indexed ipAsset);

    /// @notice Event emitted when an incentive pool is registered
    /// @param creator Address of the creator
    event IncentivePoolRegistered(address indexed creator);

    /// @notice Event emitted when an IP asset is staked
    /// @param user Address of the user
    /// @param ipAsset Address of the IP asset
    /// @param stakeTokenAddress Address of the stake token
    /// @param amount Amount of stake
    /// @param lockupType Type of lockup
    event IPAssetStaked(
        address indexed user,
        address indexed ipAsset,
        address indexed stakeTokenAddress,
        uint256 amount,
        ILockup.Type lockupType
    );

    /// @notice Event emitted when an IP asset is unstaked
    /// @param user Address of the user
    /// @param ipAsset Address of the IP asset
    /// @param stakeTokenAddress Address of the stake token
    /// @param amount Amount of stake
    /// @param lockupType Type of lockup
    event IPAssetUnstaked(
        address indexed user,
        address indexed ipAsset,
        address indexed stakeTokenAddress,
        uint256 amount,
        ILockup.Type lockupType
    );

    /// @notice Error emitted when the native token transfer fails
    error NativeTokenTransferFailed(address receiver);

    /// @notice Error emitted when the incentive pool is already registered for a given creator
    error IncentivePoolAlreadyRegistered(address creator);

    /// @notice Error emitted when the reward pool is already registered for a given creator
    error RewardPoolAlreadyRegistered(address creator, address rewardToken);

    /// @notice Calculates user rewards from staking with operator
    /// @param _operator Address of the operator
    /// @param _operatorCommissionFee Operator commission fee
    /// @param _user Address of the user
    /// @return Rewards information
    function calculateUserRewardsFromOperator(address _operator, uint256 _operatorCommissionFee, address _user)
        external
        view
        returns (IRewardPool.RewardDetail[][] memory);

    /// @notice Calculates user rewards
    /// @param _user Address of the user
    /// @return Rewards information
    function calculateUserRewards(address _user) external view returns (IRewardPool.RewardDetail[][] memory);

    /// @notice Calculates user rewards
    /// @param _operator Address of the operator
    /// @param _operatorCommissionFee Operator commission fee
    /// @param _user Address of the user
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Rewards information
    function calculateUserRewardsFromOperatorForIncentivePool(
        address _operator,
        uint256 _operatorCommissionFee,
        address _user,
        address _incentivePoolCreator
    ) external view returns (IRewardPool.RewardDetail[] memory);

    /// @notice Calculates user rewards
    /// @param _user Address of the user
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Rewards information
    function calculateUserRewardsForIncentivePool(address _user, address _incentivePoolCreator)
        external
        view
        returns (IRewardPool.RewardDetail[] memory);

    /// @notice Gets the IP asset
    /// @return Address of the IP asset
    function getIPAsset() external view returns (address);

    /// @notice Gets the incentive pool by creator
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Incentive pool
    function getIncentivePoolByCreator(address _incentivePoolCreator) external view returns (IIncentivePool);

    /// @notice Gets the reward pools
    /// @return Reward pools
    function getRewardPools() external view returns (IRewardPool.RewardPoolState[][] memory);

    /// @notice Gets the reward pools
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @return Reward pools
    function getRewardPoolsByCreator(address _incentivePoolCreator)
        external
        view
        returns (IRewardPool.RewardPoolState[] memory);

    /// @notice Gets the user reward per token
    /// @param _user Address of the user
    /// @param _incentivePoolCreator Address of the incentive pool creator
    /// @param _rewardToken Address of the reward token
    /// @return Reward per token
    function getUserRewardPerToken(address _user, address _incentivePoolCreator, address _rewardToken)
        external
        view
        returns (uint256);

    /// @notice Gets the total stake weighted in IP
    /// @return Total stake weighted in IP
    function getTotalStakeWeightedInIP() external view returns (uint256);

    /// @notice Gets the user stake weighted in IP
    /// @param _user Address of the user
    /// @return User stake weighted in IP
    function getUserStakeWeightedInIP(address _user) external view returns (uint256);

    /// @notice Gets the user stake amount for IP of the given stake tokens
    /// @param _stakeTokens Array of stake tokens
    /// @return Stake amount information
    function getTotalStakeAmountForIP(IStakeToken[] calldata _stakeTokens) external view returns (uint256[] memory);

    /// @notice Gets the user stake amount for IP
    /// @param _user Address of the user
    /// @return Stake amount information
    function getUserStakeAmountForIP(address _user)
        external
        view
        returns (UserStakeAmountDetail[][] memory);

    /// @notice Gets the user stake amount for IP for specific lockup
    /// @param _user Address of the user
    /// @param _lockup Lock up period of the stake
    /// @return Stake amount information
    function getUserStakeAmountForIPForLockup(ILockup.Type _lockup, address _user)
        external
        view
        returns (UserStakeAmountDetail[] memory);

    /// @notice Gets the user last stake block for IP for a lockup
    /// @param _lockup Type of lockup
    /// @param _user Address of the user
    /// @return Last stake timestamp
    function getUserLastStakeTimestampForIPForLockup(ILockup.Type _lockup, address _user)
        external
        view
        returns (uint256);

    /// @notice Gets the number of incentive pools
    /// @return Number of incentive pools
    function getNumIncentivePools() external view returns (uint256);
}
