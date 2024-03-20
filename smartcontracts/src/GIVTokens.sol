// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract GIVTokens {
    string private _name;
    string private _symbol;
    uint256 private _totalSupply;
    uint8 private _decimal;

    mapping(address account => uint256) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;
    mapping(address account => bool) public claimed;

    constructor(){
        _name = "GIV Access";
        _symbol = "GIV";
        _decimal = 18;
        
    }

    error ERC20InvalidSender(address sender);
    error ERC20InvalidReceiver(address receiver);
    error ERC20InsufficientBalance(address from, uint256 fromBalance, uint256 value);
    error ERC20InvalidApprover(address approver);
    error ERC20InvalidSpender(address spender);
    error ERC20InsufficientAllowance(address spender, uint256 currentAllowance, uint256 value);
    error TokenAlreadyClaimed(address receiver);

    event Approval(address owner, address spender, uint256 value);
    event Transfer(address from, address to, uint256 value);

    function name() public view virtual returns(string memory){
        return _name;
    }

    function symbol() public view virtual returns(string memory){
        return _symbol;
    }

    function decimals() public view virtual returns(uint8){
        return _decimal;
    }

    function totalSupply() public view virtual returns(uint256){
        return _totalSupply;
    }

 function balanceOf(address account) public view virtual returns(uint256){
        return _balances[account];
    }

 function claimTokens() public {
        address owner = msg.sender;
        if(!claimed[msg.sender]){
        _balances[owner] += 100 * 10**18;
        _totalSupply += 100 * 10**18;
        }else{
            revert TokenAlreadyClaimed(owner);
        }
        claimed[msg.sender] = true;
       
    }


    function transfer(address to, uint256 value) public virtual returns(bool){
        address owner = msg.sender;
        _transfer(owner, to, value);
        return true;
    }

    function allowance(address owner, address spender) public view virtual returns (uint256){
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public virtual returns(bool){
        address owner = msg.sender;
        _approve(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public virtual returns(bool){
        address spender = msg.sender;
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    function _approve(address owner, address spender, uint256 value) internal {
                  if(owner == address(0)){
                    revert ERC20InvalidApprover(address(0));
                }
                if(spender == address(0)){
                    revert ERC20InvalidSpender(address(0));
                }
                if(_balances[owner] < value){
                   revert ERC20InsufficientBalance( owner,  _balances[owner],  value);
                }
                _allowances[owner][spender] = value;
                emit Approval(owner, spender, value);
    }

   

    function _transfer(address from, address to, uint256 value) internal {
        if(from == address(0)){
            revert ERC20InvalidSender(address(0));
        }
        if(to == address(0)){
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }


    function _update(address from, address to, uint256 value)internal virtual{
        if(from == address(0) ){
            revert ERC20InvalidSender(address(0));
        }else if (to == address(0)){
            revert ERC20InvalidReceiver(address(0));
        }

        uint fromBalance = _balances[from];

        if(fromBalance < value){
            revert ERC20InsufficientBalance(from, fromBalance, value);
        }else{
            _balances[from] = fromBalance - value;
            _balances[to] += value;
        }

        emit Transfer(from, to, value);

    }

    function _spendAllowance(address owner, address spender, uint256 value) internal virtual{
        uint256 currentAllowance = allowance(owner, spender);
        if(currentAllowance < value){
            revert ERC20InsufficientAllowance(spender, currentAllowance, value);
        }
        else{
            _approve(owner, spender, currentAllowance - value);
        }

    }


    
}
