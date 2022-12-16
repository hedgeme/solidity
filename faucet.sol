// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.6.4;

contract Faucet {

    address payable owner;

    constructor () public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    receive () external payable {
        emit Deposit(msg.sender, msg.value);
    }

    event Withdrawal (address indexed to, uint amount); // indexed to all searching and filtering in any user interface
    event Deposit (address indexed from, uint amount);


    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function withdraw(uint withdraw_amount) public {
        require (address(this).balance <= 0.1 ether);
        msg.sender.transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }


 }
 
 
