// SPDX-License-Identifier: MIT
// WTF Solidity by 0xAA
// Rewritten by Volar https://twitter.com/volarcrypto

pragma solidity ^0.8.4;

interface IERC20 {
    /**
     * @dev Emits when `value` units of currency are transferred from one account (`from`) to another (`to`).
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emits when `value` units of currency are authorized from one account (`owner`) to another (`spender`).
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the total supply of tokens.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the number of tokens held by the `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Transfers `amount` units of tokens, from the caller's account to another account `to`.
     *
     * If successful, returns `true`.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the amount of tokens that `owner` account authorized to `spender` account, defaults to 0.
     *
     * When {approve} or {transferFrom} are called, `allowance` changes.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev The caller's account authorizes `amount` tokens to `spender` account.
     *
     * If successful, returns `true`.
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Transfers `amount` tokens from `from` account to `to` account through an authorization mechanism. The transferred portion will be deducted from the caller's `allowance`.
     *
     * If successful, returns `true`.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract ERC20 is IERC20 {

    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    uint256 public override totalSupply;   // Total supply of tokens

    string public name;   // Name
    string public symbol;  // Symbol
    
    uint8 public decimals = 18; // Number of decimal places
    address public owner;

    // @dev Implements the contract name and symbol at the time of contract deployment
    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
        owner = msg.sender;
    }

    // @dev Implements the `transfer` function, token transfer logic
    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // @dev Implements the `approve` function, token authorization logic
    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // @dev Implements the `transferFrom```solidity
    // @dev Implements the `transferFrom` function, token transfer logic through authorization
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // @dev Mints tokens, transfers from address `0` to the caller's address
    function mint(uint amount) external {
        require(owner == msg.sender);
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    // @dev Burns tokens, transfers from the caller's address to the `0` address
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}



