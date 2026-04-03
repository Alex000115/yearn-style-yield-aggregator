# Yield Aggregator (Yearn-style)

A professional-grade DeFi optimization engine. This repository solves the "Yield Fragmentation" problem. Instead of users manually moving funds between protocols to find the best interest rates, they deposit into this Vault. The Vault uses "Strategy" modules to programmatically shift liquidity to whichever platform offers the highest risk-adjusted returns.

## Core Features
* **EIP-4626 Standardized:** Built as a modern "Tokenized Vault" for instant compatibility with the DeFi ecosystem.
* **Modular Strategies:** Logic for individual protocols (e.g., AaveStrategy, CompoundStrategy) can be added or removed without redeploying the main vault.
* **Harvesting Logic:** Automated compounding of governance tokens (like AAVE or COMP) back into the underlying asset.
* **Flat Architecture:** Single-directory layout for the Vault Controller, Strategy Interface, and Share Token.



## Logic Flow
1. **Deposit:** User sends 1000 USDC; the Vault mints `yUSDC` shares.
2. **Rebalance:** The Controller identifies that Aave APY (5%) is higher than Compound (3%).
3. **Deploy:** The Vault moves the idle USDC into the Aave Strategy.
4. **Harvest:** Periodically, the strategy sells accrued rewards for more USDC, increasing the value of `yUSDC` shares.

## Setup
1. `npm install`
2. Deploy `YieldVault.sol`.
