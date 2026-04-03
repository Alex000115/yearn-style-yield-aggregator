// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IStrategy.sol";

/**
 * @title YieldVault
 * @dev Aggregates capital to deploy into the most profitable strategies.
 */
contract YieldVault is ERC4626, Ownable {
    IStrategy public activeStrategy;

    event StrategyUpdated(address indexed newStrategy);

    constructor(IERC20 _asset, string memory _name, string memory _symbol) 
        ERC4626(_asset) 
        ERC20(_name, _symbol) 
        Ownable(msg.sender) 
    {}

    /**
     * @dev Allows the owner to rotate capital to a new protocol.
     */
    function setStrategy(address _strategy) external onlyOwner {
        if (address(activeStrategy) != address(0)) {
            activeStrategy.withdraw(activeStrategy.balanceOf());
        }
        
        activeStrategy = IStrategy(_strategy);
        uint256 balance = IERC20(asset()).balanceOf(address(this));
        
        IERC20(asset()).approve(_strategy, balance);
        activeStrategy.deposit(balance);
        
        emit StrategyUpdated(_strategy);
    }

    /**
     * @dev Overrides totalAssets to include funds currently in strategies.
     */
    function totalAssets() public view override returns (uint256) {
        uint256 strategyBalance = address(activeStrategy) == address(0) 
            ? 0 
            : activeStrategy.balanceOf();
        return super.totalAssets() + strategyBalance;
    }
}
