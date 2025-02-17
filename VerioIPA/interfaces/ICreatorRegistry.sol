// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

import {ICreator} from "./ICreator.sol";
import {IVersionable} from "./IVersionable.sol";

interface ICreatorRegistry is IVersionable {
    /// @notice Event emitted when a creator is registered
    /// @param creator Address of the creator
    /// @param creatorState State of the creator
    event CreatorRegistered(address indexed creator, ICreator.CreatorState creatorState);

    /// @notice Event emitted when a creator is deregistered
    /// @param creator Address of the creator
    event CreatorDeregistered(address indexed creator);

    /// @notice Event emitted when a creator is updated
    /// @param creator Address of the creator
    /// @param creatorState State of the creator
    event CreatorUpdated(address indexed creator, ICreator.CreatorState creatorState);

    /// @notice Error emitted when a creator is already registered
    /// @param creator Address of the creator
    error CreatorAlreadyRegistered(address creator);

    /// @notice Error emitted when a creator is not registered
    /// @param creator Address of the creator
    error CreatorNotRegistered(address creator);

    /// @notice Error emitted when a creator is unauthorized
    /// @param creator Address of the creator
    error UnauthorizedCreator(address creator);

    /// @notice Check if a creator is valid
    /// @param _creator Address of the creator
    /// @return True if the creator is valid, false otherwise
    function isIncentivePoolCreator(address _creator) external view returns (bool);

    /// @notice Get the state of a creator
    /// @param _creator Address of the creator
    /// @return State of the creator
    function getCreatorState(address _creator) external view returns (ICreator.CreatorState memory);
}
