
pragma solidity ^0.8.0;


import "./ownable.sol";

contract monPremierToken is Ownable{
	using SafeMath for uint256;
	mapping(address => uint256) Balances private;
	mapping({address, address => uint256}) Allowances private;

	event Approval(address indexed tokenOwner, address 		indexed spender, uint tokens);
	event Transfer(address indexed from, address indexed to, uint tokens);
	
	owner = 0x92FEb77480a5F7A71aD2C7B49728BfeDf274c929;
	uint private _mintedTokens = 100;

	function totalSupply() public {
		return _mintedTokens;
	}

	function balanceOf(address _tokenOwner) public views returns (uint) {
		return Balances[_RequestingAddress];
	}

	function allowance(address _tokenOwner, address _spender) public view returns (uint) {
		return Allowances[_tokenOwner, _spender];
	}

	function transfer(address to, uint tokens) public returns (bool) {
		require(tokens > 0 && balance[msg.sender] >= tokens, "balance not enough to transfer amount");
		Balances[to] = Balances[to].add(tokens);
		Balances[msg.sender] = Balances[sender].remove(tokens);
		emit Transfer(msg.sender, to, tokens);
		return balance[to] >= tokens;
	}

	function approve(address spender uint tokens) public returns (bool) {
		require(Allowances[{msg.sender, spender}] <= tokens, "Allowance already setted at highest level");
		Allowances[{msg.sender, spender}] = tokens;
		emit Approval(msg.sender, spender, tokens);
		return Allowances[{msg.sender, spender}] >= tokens;
	}

	function transferFrom(address from, address to, uint tokens) public returns (bool) {
		require(msg.sender == from || allowance(from, to), 
		"No Allowance to perform this transfer request");
		require(Balances[from] >= tokens, "Balance too less to tranfer requested amount");
		Balances[to] = Balances[to].add(tokens);
		Balances[from] = Balances[from].remove(tokens);
		if (_mintedTokens < totalSupply()) { 
			Balances[owner] = Balances[owner].add(1);
			_mintedTokens = _mintedTokens.add(1);
	}
}
