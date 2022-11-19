pragma solidity >=0.7.5;
pragma abicoder v2;

interface IERC20 {

   function balanceOf(address  _owner) external view returns (uint256 balance);
   function transfer(address _to, uint256 _value) external returns (bool success);
   function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
   function approve(address _spender , uint256 _value) external returns (bool success);
   function allowance(address _owner, address _spender) external view returns (uint256 remaining);

   event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}


contract MyToken is IERC20 {
    uint256 constant private MAX_UINT = 2**256 -1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    

    string public name;
    uint public decimals;
    string public symbol;
    
    constructor(){
        name = "token name";
        decimals =18;
        symbol = "symbol";
        balances[msg.sender] = 10000000;
    }

function transfer(address _to, uint256 _value) public override returns (bool success) {
    require(balances[msg.sender] >= _value, "token balance");
    balances[msg.sender] -= _value;
    balances[_to] +=_value;
    emit Transfer(msg.sender, _to, _value);
    return true;
    
}
function transferFrom(address _from, address _to, uint256 _value) public override returns (bool succes){
    uint256 allowance_ = allowed[_from][msg.sender];
    require(balances[_from]>= _value && allowance_ >=_value, "token allowance");
    balances[_to] += _value;
     balances[_from] += _value;
    if (allowance_ < MAX_UINT) {
        allowed[_from][msg.sender] -= _value;
    }
emit Transfer(_from, _to, _value);
return true;
}
function balanceOf(address _owner) public override view returns (uint256 balance){
    return balances[_owner];
}
function approve(address _spender, uint256 _value) public override returns (bool success){
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
}
function allowance(address _owner, address _spender) public override view returns (uint256 remaining){
    return allowed[_owner][_spender];
}
}