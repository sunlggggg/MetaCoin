pragma solidity ^0.4.24;
import "./ConvertLib.sol";

contract MetaCoin {
	mapping (address => uint) balances;
	constructor() public {
		balances[tx.origin] = 10000;
	}
	event Transfer(bool _isEnough, address indexed _from, address indexed _to, uint256 _value, string _message);
	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) {
			//余额不足，发送失败
            emit Transfer(false, msg.sender, receiver, amount, "MetaCoin不足，发送失败");
            return false;
		} else {
			balances[msg.sender] -= amount;
			balances[receiver] += amount;
			emit Transfer(true, msg.sender, receiver, amount, "MetaCoin发送成功" );
			return true;
		}
	}
	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}
	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
